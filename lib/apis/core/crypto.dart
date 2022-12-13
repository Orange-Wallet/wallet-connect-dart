import 'package:wallet_connect_v2/apis/interfaces/i_crypto.dart';
import 'package:wallet_connect_v2/apis/interfaces/i_key_chain.dart';

class Crypto implements ICrypto {
  @override
  String name;

  @override
  // TODO: implement context
  String get context => throw UnimplementedError();

  @override
  IKeyChain keyChain;

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  bool hasKeys(String tag) {
    // TODO: implement hasKeys
    throw UnimplementedError();
  }

  @override
  Future<String> generateKeyPair() {
    // TODO: implement generateKeyPair
    throw UnimplementedError();
  }

  @override
  Future<String> generateSharedKey(
      String selfPublicKey, String peerPublicKey, String? overrideTopic) {
    // TODO: implement generateSharedKey
    throw UnimplementedError();
  }

  @override
  Future<String> setSymKey(String symKey, String? overrideTopic) {
    // TODO: implement setSymKey
    throw UnimplementedError();
  }

  @override
  Future<void> deleteKeyPair(String publicKey) {
    // TODO: implement deleteKeyPair
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSymKey(String topic) {
    // TODO: implement deleteSymKey
    throw UnimplementedError();
  }

  @override
  Future<String> encode(
      String topic, Map<String, dynamic> payload, EncodeOptions? options) {
    // TODO: implement encode
    throw UnimplementedError();
  }

  @override
  Future<String> decode(String topic, String encoded, DecodeOptions? options) {
    // TODO: implement decode
    throw UnimplementedError();
  }
}
