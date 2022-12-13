import 'package:wallet_connect_v2/apis/interfaces/i_key_chain.dart';

class EncodeOptions {
  double? type;
  String? senderPublicKey;
  String? receiverPublicKey;
}

class DecodeOptions {
  String? receiverPublicKey;
}

abstract class ICrypto {
  abstract String name;
  abstract final String context;

  abstract IKeyChain keyChain;

  Future<void> init();
  bool hasKeys(String tag);
  Future<String> generateKeyPair();
  Future<String> generateSharedKey(
    String selfPublicKey,
    String peerPublicKey,
    String? overrideTopic,
  );
  Future<String> setSymKey(String symKey, String? overrideTopic);
  Future<void> deleteKeyPair(String publicKey);
  Future<void> deleteSymKey(String topic);
  Future<String> encode(
    String topic,
    Map<String, dynamic> payload,
    EncodeOptions? options,
  );
  Future<String> decode(
    String topic,
    String encoded,
    DecodeOptions? options,
  );
}
