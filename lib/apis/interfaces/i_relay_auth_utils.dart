import 'dart:typed_data';

class JWTHeader {
  final String alg = 'EdDSA';
  final String typ = 'JWT';
}

class JWTPayload {
  String iss;
  String sub;

  JWTPayload(this.iss, this.sub);
}

class JWTData {
  JWTHeader header = JWTHeader();
  JWTPayload payload;

  JWTData(this.payload);
}

class JWTSigned extends JWTData {
  Uint8List signature;

  JWTSigned(this.signature, JWTPayload payload) : super(payload);
}

abstract class IRelayAuthUtils {
  Map<String, dynamic> decodeJson(String s);
  String encodeJson(Map<String, dynamic> value);

  String encodeIss(Uint8List publicKey);
  Uint8List decodeIss(String issuer);

  String encodeSig(Uint8List bytes);
  Uint8List decodeSig(String encoded);

  String encodeData(JWTData params);
  JWTData decodeData(String jwt);

  String encodeJWT(JWTData params);
  Uint8List decodeJWT(String encoded);
}
