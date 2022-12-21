import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pinenacl/ed25519.dart';

class KeyPair {
  final String privateKey;
  final String publicKey;

  const KeyPair(this.privateKey, this.publicKey);

  Uint8List getPrivateKeyBytes() {
    return Uint8List.fromList(hex.decode(privateKey + publicKey));
  }

  Uint8List getPublicKeyBytes() {
    return Uint8List.fromList(hex.decode(publicKey));
  }

  SigningKey toSigningKey() {
    return SigningKey.fromValidBytes(getPrivateKeyBytes());
  }

  List<int> sign(Uint8List data) {
    return toSigningKey().sign(data).toList();
  }
}

class EncryptParams {
  String message;
  String symKey;
  int? type;
  String? iv;
  String? senderPublicKey;

  EncryptParams(
    this.message,
    this.symKey, {
    this.type,
    this.iv,
    this.senderPublicKey,
  });
}

class EncodingParams {
  int type;
  Uint8List sealed;
  Uint8List iv;
  Uint8List ivSealed;
  Uint8List? senderPublicKey;

  EncodingParams(
    this.type,
    this.sealed,
    this.iv,
    this.ivSealed, {
    this.senderPublicKey,
  });
}

class EncodingValidation {
  int type;
  String? senderPublicKey;
  String? receiverPublicKey;

  EncodingValidation(
    this.type, {
    this.senderPublicKey,
    this.receiverPublicKey,
  });
}

class EncodeOptions {
  int? type;
  String? senderPublicKey;
  String? receiverPublicKey;
}

class DecodeOptions {
  String? receiverPublicKey;
}
