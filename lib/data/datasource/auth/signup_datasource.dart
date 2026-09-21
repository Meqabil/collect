import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/core/errors/app_exception.dart';
import 'package:collect/core/functions/check_internet_connection.dart';
import 'package:collect/core/security/key_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class SignUpData{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Uuid uuid = Uuid();
  Future<void> signUp({required String name,required String email,required String password}) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;
        if (user != null) {
          await user.updateDisplayName(name);
          await user.reload();
        }
        String id = uuid.v4();
        KeyService.instance.loadKeyForUser(auth.currentUser!.uid);
        await firestore.collection('users').doc(id).set({
          'id' : id,
          'uid': auth.currentUser!.uid,
          'name' : name,
          'email' : email,
          'created_at': FieldValue.serverTimestamp(),
          'last_sign': FieldValue.serverTimestamp(),
        });
      } on FirebaseAuthException catch (e){
        switch (e.code){
          case 'email-already-in-use':
            throw AuthException('email_already_in_use');

          case 'invalid-email':
            throw AuthException('invalid_email'.tr);

          case 'weak-password':
            throw AuthException('weak_password');

          case 'network-request-failed':
            throw NoInternetException();

          default:
            throw AuthException('signup_failed'.tr);
        }
      } catch (e){
        throw AuthException("signup_failed".tr);
      }
    }else{
      throw NoInternetException();
    }
  }

}