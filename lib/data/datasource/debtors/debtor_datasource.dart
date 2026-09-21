import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/core/errors/app_exception.dart';
import 'package:collect/core/errors/handle_firestore_exception.dart';
import 'package:collect/core/security/encryption_service.dart';
import 'package:collect/data/models/debtors/debtor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../core/functions/check_internet_connection.dart';

class DebtorData{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addDebtor({required String id,required String name,required String category,String phoneNumber = '',String address = '',String note = '',}) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        String encryptedNote = note == '' ? '' : await CipherService.encrypt(note);
        String encryptedPhoneNumber = phoneNumber == '' ? '' : await CipherService.encrypt(phoneNumber);
        String encryptedAddress = address == '' ? '' : await CipherService.encrypt(address);
        String encryptedCategory = category == '' ? '' : await CipherService.encrypt(category);
        await _db.collection("debtors").add({
          "id": id,
          "user_id": _auth.currentUser!.uid,
          "created_at": FieldValue.serverTimestamp(),
          "last_status":"initial",
          "name": name,
          "note": encryptedNote,
          "phone": encryptedPhoneNumber,
          "address": encryptedAddress,
          "category": encryptedCategory,
        });
      }on FirebaseException catch (e){
        handleFirestoreError('add'.tr, e);
      }catch (e){
        print("|||        Error         ||| =>> $e ");
        throw DebtorException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }


  Future<void> updateDebtor({required String debtorId,required String name,required String note,required String address,required String phoneNumber,required String category,}) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _db.collection("debtors").where("user_id",isEqualTo: _auth.currentUser!.uid).where("id",isEqualTo:  debtorId).get();
        final debtor = data.docs.first;
        final docId = debtor.id;
        await _db.collection("debtors").doc(docId).update({
          "last_status": "initial",
          "name": name,
          "phone": phoneNumber == '' ? '' : await CipherService.encrypt(phoneNumber),
          "address": address == '' ? '' : await CipherService.encrypt(address),
          "category": category == '' ? '' : await CipherService.encrypt(category),
          "note": note == '' ? '' : await CipherService.encrypt(note),
        });
      }on FirebaseException catch (e){
        handleFirestoreError('update'.tr, e);
      }catch (e){
        throw DebtorException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }



  Future<DebtorModel> getDebtor(String id) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _db.collection('debtors').where("id",isEqualTo: id).where('user_id',isEqualTo: _auth.currentUser!.uid).get();
        final debtor = data.docs.where((e) => e['id'] == id).first.data();
        return DebtorModel(
          id: debtor['id'] ?? '',
          userId: debtor['user_id'],
          name: debtor['name'] ?? '',
          phone: debtor['phone'].isEmpty ? '' : await CipherService.decrypt(debtor['phone']),
          address: debtor['address'].isEmpty ? '' : await CipherService.decrypt(debtor['address']),
          category: debtor['category'].isEmpty ? '' :  await CipherService.decrypt(debtor['category']),
          note: debtor['note'].isEmpty ? '' : await CipherService.decrypt(debtor['note']),
          lastStatus: debtor['last_status'] ?? '',
          createdAt: debtor['created_at'].toDate() ?? DateTime.now(),
        );
      }on FirebaseException catch (e){
        handleFirestoreError('get'.tr, e);
      } catch (e){
        throw DebtorException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
    return DebtorModel(id: 'Unknown', userId: "Unknown", name: 'Unknown', phone: '', address: '', category: '', note: '', lastStatus: '', createdAt: DateTime.now());
  }

  Future<List<DebtorModel>> getAllDebtors() async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        var res = await _db.collection('debtors').where("user_id",isEqualTo: _auth.currentUser!.uid).get();
        final debtors = await Future.wait(res.docs.map((doc) async{
          final data = doc.data();
          return DebtorModel(
            id: data['id'] ?? '',
            userId: data['user_id'],
            name: data['name'] ?? '',
            phone: data['phone'].isEmpty ? '' : await CipherService.decrypt(data['phone']),
            address: data['address'].isEmpty ? '' : await CipherService.decrypt(data['address']),
            category: data['category'].isEmpty ? '' :  await CipherService.decrypt(data['category']),
            note: data['note'].isEmpty ? '' : await CipherService.decrypt(data['note']),
            lastStatus: data['last_status'] ?? '',
            createdAt: data['created_at'].toDate() ?? DateTime.now(),
          );
        }).toList());
        return debtors;
      }on FirebaseException catch (e){
        handleFirestoreError('get'.tr, e);
      } catch (e){
        throw DebtorException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
    return [];
  }

  Future<void> deleteDebtor(String debtorId) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final data = await _db.collection('debtors').where("user_id",isEqualTo: _auth.currentUser!.uid).where('id',isEqualTo: debtorId).get();
        final debtorDoc = data.docs.first.id;
        await _db.collection('debtors').doc(debtorDoc).delete();
      } on FirebaseException catch (e){
        handleFirestoreError('delete'.tr, e);
      } catch (e){
        throw DebtorException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }


}