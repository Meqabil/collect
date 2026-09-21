import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/core/errors/app_exception.dart';
import 'package:collect/core/errors/handle_firestore_exception.dart';
import 'package:collect/core/security/encryption_service.dart';
import 'package:collect/data/models/debts/debt_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:uuid/uuid.dart';

import '../../../core/functions/check_internet_connection.dart';

class DebtsData{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> addDebt({required String debtorId,required double totalDebt,required String type,required DateTime nextDate,int numOfInstallments = 0,double valueOfFirstOfInstallment = 0,})async {
  bool connected = await checkInternetConnection();
    if(connected){
      try{
        Uuid uuid = Uuid();
        String id =  uuid.v4();
        String encryptedType = await CipherService.encrypt(type);
        _firestore.collection('debts').add({
          "id": id,
          "debtor_id": debtorId,
          "debt_status": "active",
          "last_payed": FieldValue.serverTimestamp(),
          "opening_money": totalDebt,
          "changed_money": 0,
          "debt": totalDebt,
          "type": encryptedType,
          "num_of_installments": numOfInstallments,
          "value_of_first_installment": valueOfFirstOfInstallment,
          "next_date": nextDate,
          "created_at": FieldValue.serverTimestamp(),
        });
      } on FirebaseException catch(e){
        handleFirestoreError('add_debts'.tr, e);
      } catch (e){
        print("|||        Error         ||| =>> $e ");
        throw DebtException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }

  Future<DebtModel> getDebt(String debtorId) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _firestore.collection("debts").where('debtor_id',isEqualTo: debtorId).get();
        final debtData = data.docs.first.data();
        final debt = DebtModel(
            id: debtData['id'],
            debtorId: debtData['debtor_id'],
            debtStatus: debtData['debt_status'],
            type: await CipherService.decrypt(debtData['type'])  ,
            debt: debtData['debt'],
            openingMoney: debtData['opening_money'],
            changedMoney: debtData['changed_money'].toDouble() ?? 0,
            numOfInstallments: debtData['num_of_installments'],
            valueOfFirstInstallment: debtData['value_of_first_installment'],
            createdAt: debtData['created_at'].toDate() ?? DateTime.now(),
            nextDate: debtData['next_date'].toDate() ?? DateTime.now(),
            lastPayed: debtData['last_payed'].toDate() ?? DateTime.now()
        );
        return debt;
      }on FirebaseException catch(e){
        handleFirestoreError('get_debt'.tr, e);
      } catch(e){
        throw DebtException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
    return DebtModel(id:  '',debtorId: 'debtorId', debtStatus: 'debtStatus',changedMoney: 0, type: 'type', debt: 50000, openingMoney: 50000, numOfInstallments: 2, valueOfFirstInstallment: 511, createdAt: DateTime.now(), nextDate: DateTime.now(), lastPayed: DateTime.now());
  }

  Future<List<DebtModel>> getDebts(String debtorId) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _firestore.collection("debts").where('debtor_id',isEqualTo: debtorId).get();
        final debts = await Future.wait(data.docs.map((doc) async{
          final debt = doc.data();
          return DebtModel(
            id: debt['id'],
            debtorId: debt['debtor_id'],
            debtStatus: debt['debt_status'],
            type: await CipherService.decrypt(debt['type'])  ,
            debt: debt['debt'],
            openingMoney: debt['opening_money'],
            changedMoney: debt['changed_money'].toDouble() ?? 0,
            numOfInstallments: debt['num_of_installments'],
            valueOfFirstInstallment: debt['value_of_first_installment'],
            createdAt: debt['created_at'].toDate() ?? DateTime.now(),
            nextDate: debt['next_date'].toDate() ?? DateTime.now(),
            lastPayed: debt['last_payed'].toDate() ?? DateTime.now()
          );
        }));
        return debts;
      }on FirebaseException catch(e){
        handleFirestoreError('get_debts'.tr, e);
      } catch(e){
        throw DebtException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
    return [];
  }

  Future<List<DebtModel>> getDebtsStateAll(String condition) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final debtorData = await _firestore.collection('debtors').where('user_id',isEqualTo: _auth.currentUser!.uid).get();
        final debtorsList = debtorData.docs.map((e) => e['id']).toList();
        if(debtorsList.isEmpty) return [];
        final data = await _firestore.collection('debts').where('debtor_id',whereIn: debtorsList).where('debt_status',isEqualTo: 'active').get();
        var elements = data.docs;
        if(condition == 'all'){
          elements = elements.where((e) => e["debt_status"] == "active").toList();
        }else if(condition == 'due'){
          elements = elements.where((e) => e["debt_status"] == "active").where((e) => e['next_date'].toDate().day == DateTime.now().day && e['next_date'].toDate().month == DateTime.now().month && e['next_date'].toDate().year == DateTime.now().year).toList();
        }else if(condition == 'late'){
          elements = elements.where((e) => e['next_date'].toDate().compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)) == -1).toList();
        }else if(condition == 'nearly'){
          elements = elements.where((e) => e['next_date'].toDate().year * 365.25 +  e['next_date'].toDate().month * 30 +  e['next_date'].toDate().day - DateTime.now().year * 365.25 - DateTime.now().month * 30 - DateTime.now().day <= 15).toList();
        }else if(condition == 'payed'){
          elements = elements.where((e) => e['created_at'].toDate().toString().substring(0,10) != DateTime.now().toString().substring(0,10)).where((e) => e['last_payed'].toDate().toString().substring(0,10) ==  DateTime.now().toString().substring(0,10)).toList();
        }
        return elements.map((e) => DebtModel.fromJson(e.data())).toList();
      }on FirebaseException catch(e){
        handleFirestoreError('get_debts'.tr, e);
      } catch (e){
        throw DebtException(e.toString());
      }

    }else{
      throw NoInternetException();
    }
    return [];
  }


  Future<List> getDebtsSummary() async{
    bool connected = await checkInternetConnection();
    if(connected){
      try {
        final debtorData = await _firestore.collection('debtors').where('user_id',isEqualTo: _auth.currentUser!.uid).get();
        final debtorsList = debtorData.docs.map((e) => e['id']).where((id) => id.isNotEmpty).toList();
        if(debtorsList.isEmpty) return [0,0,0,0,0,0,0,0];
        final data = await _firestore.collection('debts').where('debtor_id',whereIn: debtorsList).get();
        final installmentsData = await _firestore.collection('installments').where('debtor_id',whereIn: debtorsList).get();
        final debts = data.docs;
        final installments = installmentsData.docs;
        final fullDebtsMoney = debts.fold<double>(
          0,
              (sum, doc) => sum + (doc.data()['debt'] ?? 0),
        );
        final fullTodayDebtsMoney = debts.where((e) => e['next_date'].toDate().toString().substring(0,10) == DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).toString().substring(0,10)).toList()
            .fold<double>(
            0,
                (sum,doc) => sum + (doc.data()['debt'] ?? 0)
        );

        final fullLateDebtsMoney = debts.where((e) => DateTime(e['next_date'].toDate().year,e['next_date'].toDate().month,e['next_date'].toDate().day,).compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,)) == -1).toList()
            .fold<double>(
            0,
                (sum,doc) => sum + (doc.data()['debt'] ?? 0)
        );

        final fullPayedToday = installments.where((e) => DateTime(e['created_at'].toDate().year,e['created_at'].toDate().month,e['created_at'].toDate().day,) == DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,),).toList()
            .fold<double>(
            0,
                (sum,doc) => sum + (doc.data()['installment'] ?? 0)
        );
        final fullPayed = installments.toList()
            .fold<double>(
            0,
                (sum,doc) => sum + (doc.data()['installment'] ?? 0)
        );
        return [fullDebtsMoney,fullTodayDebtsMoney,fullLateDebtsMoney,fullPayedToday,fullPayed];
      }on FirebaseException catch(e){
        handleFirestoreError('get_debts'.tr, e);
      } catch (e){
        throw DebtException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
    return [0,0,0,0,0,0,0,0,0];
  }


  Future<void> deleteDebt(String debtId) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _firestore.collection('debts').where('id',isEqualTo: debtId).get();
        final debtDoc = data.docs.first.id;
        await _firestore.collection('debts').doc(debtDoc).delete();
      } on FirebaseException catch (e){
        handleFirestoreError('delete'.tr, e);
      } catch (e){
        throw DebtException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }
}


