import 'dart:convert';

import 'package:collect/core/security/key_service.dart';
import 'package:cryptography/cryptography.dart';
class CipherService {

  static final _algorithm = AesGcm.with256bits();

  //encrypt plaintext
  static Future<String> encrypt(String plainText) async{
    final key = KeyService.instance.key;
    final nonce = _algorithm.newNonce();
    final secretBox = await _algorithm.encrypt(
      utf8.encode(plainText),
      secretKey: key,
      nonce: nonce
    );

    final combined = {
      'n': base64Encode(secretBox.nonce),
      'c': base64Encode(secretBox.cipherText),
      'm': base64Encode(secretBox.mac.bytes),
    };
    return jsonEncode(combined);
  }

  // decrypt ciphertext
  static Future<String> decrypt(String cipherText) async {
    final key = KeyService.instance.key;
    final map = jsonDecode(cipherText) as Map<String, dynamic>;

    final secretBox = SecretBox(
      base64Decode(map['c'] as String),
      nonce: base64Decode(map['n']),
      mac: Mac(base64Decode(map['m']))
    );
    final decrypted = await _algorithm.decrypt(secretBox, secretKey: key);
    return utf8.decode(decrypted);
  }
}





