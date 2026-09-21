import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/core/errors/app_exception.dart';
import 'package:collect/core/functions/check_internet_connection.dart';
import 'package:collect/core/security/key_service.dart';
import 'package:collect/main.dart';
import 'package:collect/view/errors/no_internet_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginData{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<User?> login({required String email,required String password}) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final user = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final data = await firestore.collection('users').get();
        final String id = data.docs.where((e) => email == e['email']).first['id'];
        await firestore.collection('users').doc(id).update({
          'last_sign': FieldValue.serverTimestamp(),
        });
        final uid = user.user!.uid;
        KeyService.instance.loadKeyForUser(uid);
        return user.user;
      } on FirebaseAuthException catch (e){
        switch (e.code) {
          case 'invalid-credential':
            throw AuthException('wrong_email_or_password'.tr);
          case 'invalid-email':
            throw AuthException('invalid_email'.tr);
          case 'user-disabled':
            throw AuthException('user_disabled'.tr);
          case 'too-many-requests':
            throw AuthException('too_many_requests'.tr);
          case 'network-request-failed':
            throw NoInternetException();
          default:
            throw AuthException('something_went_error'.tr);
        }
      } catch (e){
        throw AuthException(e.toString());
      }
    }else{
      throw NoInternetScreen();
    }
  }

  Future<UserCredential?> loginWithGoogle() async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
        if(googleSignInAccount == null) return null;

        final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken
        );
        final data = await firestore.collection('users').get();
        final isEmailLoggedInBefore = data.docs.any((e) => e['email'] == googleSignInAccount.email);
        if(!isEmailLoggedInBefore){
          firestore.collection('users').doc(googleSignInAccount.id).set({
            'id' : googleSignInAccount.id,
            'uid': _auth.currentUser!.uid,
            'name': googleSignInAccount.displayName,
            'email': googleSignInAccount.email,
            'created_at': FieldValue.serverTimestamp(),
            'last_sign': FieldValue.serverTimestamp(),
          });
        }else{
          firestore.collection('users').doc(googleSignInAccount.id).update({
            'last_sign': FieldValue.serverTimestamp(),
          });
        }
        prefs!.setString('logged_in', 'yes');
        KeyService.instance.loadKeyForUser(_auth.currentUser!.uid);
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } on PlatformException catch (e){
        switch (e.code) {
          case 'sign_in_canceled':
            throw AuthException('sign_in_cancelled'.tr);
          case 'network_error':
            throw NoInternetException();
          case 'sign_in_failed':
            throw AuthException('google_configuration_failed'.tr);
          default:
            throw AuthException('something_went_error'.tr);
        }
      } on FirebaseAuthException catch (e){
        switch (e.code) {
          case 'account-exists-with-different-credential':
            throw AuthException('account_f_w_d_p'.tr);
          case 'invalid-credential':
            throw AuthException('invalid_credential'.tr);
          default:
            throw AuthException('something_went_error'.tr);
        }
      } catch (e){
        throw AuthException(e.toString());
      }
    }else{
      throw NoInternetException();
    }

  }


  Future<void> sendResetPasswordEmail(String email) async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        _auth.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (e){
        switch (e.code) {
          case 'invalid-credential':
            throw AuthException('wrong_email_or_password'.tr);
          case 'invalid-email':
            throw AuthException('invalid_email'.tr);
          case 'user-disabled':
            throw AuthException('user_disabled'.tr);
          case 'too-many-requests':
            throw AuthException('too_many_requests'.tr);
          case 'network-request-failed':
            throw NoInternetException();
          default:
            throw AuthException('something_went_error'.tr);
        }
      } catch (e){
        throw AuthException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }
  Future<void> signOut() async{
    bool connected = await checkInternetConnection();
    if(connected){
      try{
        _auth.signOut();
      }catch (e){
        throw AuthException(e.toString());
      }
    }else{
      throw NoInternetException();
    }
  }
}
