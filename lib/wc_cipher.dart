import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:hex/hex.dart';
import 'package:wallet_connect/models/exception/exceptions.dart';
import 'package:wallet_connect/models/wc_encryption_payload.dart';

class WCCipher {
  static Future<String> decrypt(WCEncryptionPayload payload, String key) async {
    final data = HEX.decode(payload.data);
    final _iv = HEX.decode(payload.iv);
    final _keyBytes = HEX.decode(key);
    final computedHmac = await _computeHmac(data, _iv, _keyBytes);
    if (payload.hmac.toLowerCase() != HEX.encode(computedHmac.bytes)) {
      throw HmacException();
    }
    final algorithm = AesCbc.with256bits(macAlgorithm: MacAlgorithm.empty);
    final secretKey = SecretKey(_keyBytes);
    final secretBox = SecretBox(data, nonce: _iv, mac: Mac.empty);
    final clearText = await algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
    );
    return utf8.decode(clearText);
  }

  static Future<WCEncryptionPayload> encrypt(String data, String key) async {
    final _keyBytes = HEX.decode(key);
    final algorithm = AesCbc.with256bits(macAlgorithm: MacAlgorithm.empty);
    final secretKey = SecretKey(_keyBytes);
    final secretBox = await algorithm.encrypt(
      utf8.encode(data),
      secretKey: secretKey,
    );
    print('Nonce: ${secretBox.nonce}');
    print('Ciphertext: ${secretBox.cipherText}');
    print('MAC: ${secretBox.mac.bytes}');
    final computedHmac =
        await _computeHmac(secretBox.cipherText, secretBox.nonce, _keyBytes);
    final encryptedData = HEX.encode(secretBox.cipherText);
    return WCEncryptionPayload(
      data: encryptedData,
      hmac: HEX.encode(computedHmac.bytes),
      iv: HEX.encode(secretBox.nonce),
    );
  }

  static Future<Mac> _computeHmac(
      List<int> data, List<int> iv, List<int> key) async {
    final hmac = Hmac.sha256();
    final payload = data + iv;
    final mac = await hmac.calculateMac(payload, secretKey: SecretKey(key));
    return mac;
  }
}
