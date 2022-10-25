import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:wallet_connect/models/exception/exceptions.dart';
import 'package:wallet_connect/models/wc_encryption_payload.dart';
import 'package:wallet_connect/utils/hex.dart';

class WCCipher {
  static Future<String> decrypt(WCEncryptionPayload payload, String key) async {
    final data = hexToBytes(payload.data);
    final _iv = hexToBytes(payload.iv);
    final _keyBytes = hexToBytes(key);
    final computedHmac = await _computeHmac(data, _iv, _keyBytes);
    if (payload.hmac.toLowerCase() != bytesToHex(computedHmac.bytes)) {
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
    final _keyBytes = hexToBytes(key);
    final algorithm = AesCbc.with256bits(macAlgorithm: MacAlgorithm.empty);
    final secretKey = SecretKey(_keyBytes);
    final secretBox = await algorithm.encrypt(
      utf8.encode(data),
      secretKey: secretKey,
    );
    final computedHmac =
        await _computeHmac(secretBox.cipherText, secretBox.nonce, _keyBytes);
    final encryptedData = bytesToHex(secretBox.cipherText);
    return WCEncryptionPayload(
      data: encryptedData,
      hmac: bytesToHex(computedHmac.bytes),
      iv: bytesToHex(secretBox.nonce),
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
