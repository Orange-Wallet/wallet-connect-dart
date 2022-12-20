import 'dart:typed_data';

import 'package:wallet_connect_v2/apis/core/crypto/crypto_models.dart';
import 'package:wallet_connect_v2/apis/core/relay_auth/relay_auth_models.dart';

abstract class IRelayAuth {
  // API
  Future<String> signJWT(
    String subject,
    String aud,
    int ttl,
    KeyPair keyPair, {
    int? iat,
  });
  Future<bool> verifyJWT(String jwt);

  // Auth
  Map<String, dynamic> decodeJson(String s);
  String encodeJson(Map<String, dynamic> value);

  String encodeIss(Uint8List publicKey);
  Uint8List decodeIss(String issuer);

  String encodeSig(Uint8List bytes);
  Uint8List decodeSig(String encoded);

  Uint8List encodeData(JWTData params);
  JWTData decodeData(Uint8List data);

  String encodeJWT(JWTSigned params);
  JWTDecoded decodeJWT(String encoded);
}
