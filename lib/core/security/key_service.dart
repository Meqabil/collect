import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptography/cryptography.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyService {
  KeyService._internal();
  static final KeyService instance = KeyService._internal();
  final _storage  = FlutterSecureStorage();
  final AesGcm _algorithm = AesGcm.with256bits();
  SecretKey? _encryptionKey;
  String? _currentUid;

  SecretKey get key {
    if(_encryptionKey == null){
      loadKeyForUser(FirebaseAuth.instance.currentUser!.uid);
      throw StateError('encryption not loaded !');
    }
    return _encryptionKey!;
  }
  bool get isLoaded  => _encryptionKey != null;


  Future<void> loadKeyForUser(String uid) async{
    if(_encryptionKey != null && _currentUid == uid) return;
    final localCachedKey = 'aes_key$uid';
    final String? cached = await _storage.read(key: localCachedKey);
    if(cached != null){
      final bytes = base64Decode(cached);
      _encryptionKey = SecretKey(bytes);
      _currentUid = uid;
      return;
    }


    final docRef = await FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: uid).get();
    final doc = docRef.docs.first;
    if(doc.exists && doc.data()['key'] != null){
      final keyB64 = doc.data()['key'] as String;
      await _storage.write(key: localCachedKey, value: keyB64);
      _encryptionKey = SecretKey(base64Decode(keyB64));
      _currentUid = uid;
      return;
    }
    //First time ever for generate key
    final newSecretKey = await _algorithm.newSecretKey();
    final newKeyBytes = await newSecretKey.extractBytes();
    final newKeyB64 = base64Encode(newKeyBytes);

    await FirebaseFirestore.instance.collection('users').doc(doc.id).set({'key': newKeyB64,},SetOptions(merge: true));
    await _storage.write(key: localCachedKey, value: newKeyB64);
    _encryptionKey = newSecretKey;
    _currentUid = uid;
  }

  void signOutClear(){
    _encryptionKey = null;
    _currentUid = null;
  }


}