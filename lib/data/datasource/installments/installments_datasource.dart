import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/core/errors/app_exception.dart';
import 'package:collect/core/errors/handle_firestore_exception.dart';
import 'package:collect/data/models/installments/delay_model.dart';
import 'package:collect/data/models/installments/increases_or_decreases_model.dart';
import 'package:collect/data/models/installments/installment_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../core/functions/check_internet_connection.dart';

class InstallmentsData{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> delayInstallment({required String debtId,required String debtorId,required String debt,required String note,required String reason,required String meanOfContact,required DateTime delayedFrom,required DateTime delayedTo,})async {
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        Uuid uuid = Uuid();
        String id =  uuid.v4();
        final data = await _db.collection("debts").where("id",isEqualTo: debtId).get();
        final docId = data.docs.first.id;
        await _db.collection("debts").doc(docId).update({
          "next_date":delayedTo,
        });
        await _db.collection('delays').add({
          "id": id,
          "debt_id": debtId,
          "debtor_id": debtorId,
          "debt": debt,
          "reason": reason,
          "note": note,
          "mean_of_contact": meanOfContact,
          "delayed_to": delayedTo,
          "delayed_from": delayedTo,
          "created_at": FieldValue.serverTimestamp(),
        });
      } on FirebaseException catch (e){
        handleFirestoreError('delay'.tr, e);
      } catch (e){
        throw InstallmentException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }

  Future<void> payInstallment({required String debtId,required String debtorId,required double installment,required String note,required String method,required String meanOfContact,required DateTime nextDate}) async {
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        Uuid uuid = Uuid();
        String id =  uuid.v4();
        final data = await _db.collection("debts").where("id",isEqualTo: debtId).get();
        final docId = data.docs.first.id;
        final double debt = data.docs.first['debt'];
        await _db.collection("debts").doc(docId).update({
          "next_date": nextDate,
          "last_payed": FieldValue.serverTimestamp(),
          "debt": debt - installment,
        });
        await _db.collection('installments').add({
          "id": id,
          "debt_id": debtId,
          "debtor_id": debtorId,
          "installment": installment,
          "method": method,
          "note": note,
          "mean_of_contact": meanOfContact,
          "next_date": nextDate,
          "created_at": FieldValue.serverTimestamp(),
        });
      }on FirebaseException catch (e){
        handleFirestoreError('pay_installment'.tr, e);
      } catch (e){
        throw InstallmentException(e.toString());
      }

    }else{
      throw NoInternetException();
    }
  }

  Future<void> settle({required String debtId,required String debtorId,required String note,required}) async {
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        Uuid uuid = Uuid();
        String id =  uuid.v4();
        final data = await _db.collection("debts").where("id",isEqualTo: debtId).get();
        final docId = data.docs.first.id;
        final double debt = data.docs.first['debt'];
        await _db.collection("debts").doc(docId).update({
          "next_date": DateTime(2100,1,1),
          "last_payed": FieldValue.serverTimestamp(),
          "debt": 0.0,
          "debt_status": "passive",
        });
        await _db.collection('installments').add({
          "id": id,
          "debt_id": debtId,
          "debtor_id": debtorId,
          "installment": debt,
          "method": "Cash",
          "note": note,
          "mean_of_contact": "Call",
          "next_date": DateTime(2100,1,1),
          "created_at": FieldValue.serverTimestamp(),
        });
      }on FirebaseException catch (e){
        handleFirestoreError('settle'.tr, e);
      } catch (e){
        throw InstallmentException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }


  Future<void> increaseOrDecreaseDebt({required String debtId,required String debtorId,required double installment,required String note,required bool increase}) async {
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        Uuid uuid = Uuid();
        String id =  uuid.v4();
        final data = await _db.collection("debts").where("id",isEqualTo: debtId).get();
        final docId = data.docs.first.id;
        final double debt = data.docs.first['debt'];
        await _db.collection("debts").doc(docId).update({
          "debt": increase ? debt + installment : debt - installment,
          "last_payed": FieldValue.serverTimestamp(),
          "changed_money" : increase ? installment + data.docs.first['changed_money'].toInt()   : installment * - 1 + data.docs.first['changed_money'].toInt() ,
        });
        await _db.collection('increases').add({
          "id": id,
          "debt_id": debtId,
          "debtor_id": debtorId,
          "installment": installment,
          "note": note,
          "type": increase ? "increase":"decrease",
          "created_at": FieldValue.serverTimestamp(),
        });
      }on FirebaseException catch (e){
        handleFirestoreError('settle'.tr, e);
      } catch (e){
        throw InstallmentException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }

  Future<List<InstallmentModel>> getAllInstallments(String debtorId)async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _db.collection("installments").orderBy("created_at",descending: false).get();
        final installments = data.docs.where((e) => e['debtor_id'] == debtorId).map((e) => InstallmentModel.fromJson(e.data())).toList();
        return installments;

      }on FirebaseException catch (e){
        handleFirestoreError('settle'.tr, e);
      } catch (e){
        throw InstallmentException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
    return [];
  }
  Future<List<DelayModel>> getAllDelaysForDebt(String debtorId)async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _db.collection("delays").orderBy("created_at",descending: false).get();
        final delays = data.docs.where((e) => e['debtor_id'] == debtorId).map((e) => DelayModel.fromJson(e.data())).toList();
        return delays;

      }on FirebaseException catch (e){
        handleFirestoreError('delays'.tr, e);
      } catch (e){
        throw InstallmentException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
    return [];
  }

  Future<List<IncreasesOrDecreasesModel>> getAllChangesInDebt(String debtorId)async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _db.collection("increases").orderBy("created_at",descending: false).get();
        final changes = data.docs.where((e) => e['debtor_id'] == debtorId).map((e) => IncreasesOrDecreasesModel.fromJson(e.data())).toList();
        return changes;
      }on FirebaseException catch (e){
        handleFirestoreError('delays'.tr, e);
      } catch (e){
        throw InstallmentException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
    return [];
  }

  Future<void> deleteDelay(String id,String debtorId) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final dataForOneDelay = await _db.collection("delays").where("id",isEqualTo: id).get();
        final dataForAllDelays = await _db.collection("delays").where("debtor_id",isEqualTo: debtorId).get();
        List delays = dataForAllDelays.docs.toList();
        delays.sort((a,b){
          final dateA = (a['created_at'] as Timestamp).toDate();
          final dateB = (b['created_at'] as Timestamp).toDate();
          return dateA.compareTo(dateB);
        });
        final String docId = dataForOneDelay.docs.first.id;
        final debtsData = await _db.collection("debts").where("debtor_id",isEqualTo: debtorId).get();
        final docDebtId = debtsData.docs.first.id;
        DateTime? tempDate;
        if(delays[delays.length - 1]['id'] == dataForOneDelay.docs.first['id']){
          if(delays.length > 1){
            tempDate = delays[delays.length - 2]['delayed_to'].toDate();
          }else if(delays.isEmpty){}
          else{
            tempDate = delays[0]['delayed_to'].toDate();
          }
        }
        if(tempDate != null){
          await _db.collection("debts").doc(docDebtId).update({
          "next_date": tempDate,
          });
        }
        await _db.collection("delays").doc(docId).delete();
      }on FirebaseException catch (e){
        handleFirestoreError('delays'.tr, e);
      } catch (e){
        throw InstallmentException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }

  Future<void> deleteInstallment(String installmetId, String debtorId) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _db.collection("installments").where("id",isEqualTo: installmetId).get();
        final String docId = data.docs.first.id;
        final intallmentsData = await _db.collection("installments").where("debtor_id",isEqualTo: debtorId).get();
        final intallmentsLength = intallmentsData.docs.length;
        final double installment = data.docs.first['installment'];
        DateTime? tempDate;
        if(data.docs.first['id'] == intallmentsData.docs[intallmentsLength - 1]){
          if(intallmentsLength > 1){
            tempDate = intallmentsData.docs[intallmentsLength - 2]['next_date'];
          }else{
            tempDate = intallmentsData.docs[0]['next_date'];
          }
        }
        await _db.collection("installments").doc(docId).delete();
        final debtsData = await _db.collection("debts").where("debtor_id",isEqualTo: debtorId).get();
        final docDebtId = debtsData.docs.first.id;
        final double debt = debtsData.docs.first['debt'];
        if(tempDate == null){
          await _db.collection("debts").doc(docDebtId).update({
            "debt": debt + installment,
          });
        }else{
          await _db.collection("debts").doc(docDebtId).update({
            "last_payed": tempDate,
            "next_date": tempDate,
            "debt": debt + installment,
          });
        }
      }on FirebaseException catch (e){
        handleFirestoreError('delays'.tr, e);
      } catch (e){
        throw InstallmentException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }

  Future<void> deleteChangeInDebt(String id, String debtorId) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _db.collection("increases").where("id",isEqualTo: id).get();
        final String docId = data.docs.first.id;

        await _db.collection("delays").doc(docId).delete();
        final debtsData = await _db.collection("debts").where("debtor_id",isEqualTo: debtorId).get();
        final docDebtId = debtsData.docs.first.id;
        final double debt = debtsData.docs.first['debt'];
        final changeMoney = debtsData.docs.first['changed_money'];
        final installment = data.docs.first['installment'];
        if(data.docs.first['type'] == "increase"){
          await _db.collection("debts").doc(docDebtId).update({
            "changed_money": changeMoney - installment,
            "debt": debt - installment,
          });
        }else{
          await _db.collection("debts").doc(docDebtId).update({
            "changed_money": changeMoney + installment,
            "debt": debt + installment,
          });
        }
        await _db.collection("increases").doc(docId).delete();
      }on FirebaseException catch (e){
        handleFirestoreError('delete'.tr, e);
      } catch (e){
        throw InstallmentException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }


  Future<bool> hasSettled(String debtorId)async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _db.collection("installments").where("debtor_id",isEqualTo: debtorId).get();
        final settled = data.docs.any((e) => e['next_date'].toDate().year == 2100);
        return settled;
      }on FirebaseException catch (e){
        handleFirestoreError('has_settled'.tr, e);
      } catch (e){
        throw InstallmentException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
    return false;
  }
}