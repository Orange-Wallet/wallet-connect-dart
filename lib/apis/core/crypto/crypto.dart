import 'dart:convert';

import 'package:wallet_connect_v2/apis/core/crypto/crypto_models.dart';
import 'package:wallet_connect_v2/apis/core/crypto/crypto_utils.dart';
import 'package:wallet_connect_v2/apis/core/key_chain.dart';
import 'package:wallet_connect_v2/apis/interfaces/i_crypto.dart';
import 'package:wallet_connect_v2/apis/interfaces/i_crypto_utils.dart';
import 'package:wallet_connect_v2/apis/interfaces/i_key_chain.dart';
import 'package:wallet_connect_v2/apis/utils/errors.dart';

class Crypto implements ICrypto {
  static const CRYPTO_CONTEXT = 'crypto';
  static const CRYPTO_CLIENT_SEED = 'client_ed25519_seed';
  static const CRYPTO_JWT_TTL = 'ONE DAY'; // TODO: Fix this

  bool _initialized = false;

  @override
  String get name => CRYPTO_CONTEXT;

  @override
  IKeyChain? keyChain;
  ICryptoUtils? utils;

  Crypto({this.keyChain, this.utils});

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }
    if (keyChain == null) {
      keyChain = KeyChain();
    }
    if (utils == null) {
      utils = CryptoUtils();
    }

    await keyChain!.init();
    _initialized = true;
  }

  @override
  bool hasKeys(String tag) {
    _checkInitialized();
    return keyChain!.has(tag);
  }

  @override
  Future<String> getClientId() async {
    _checkInitialized();
    // TODO: implement generateKeyPair
    throw UnimplementedError();
  }

  @override
  Future<String> generateKeyPair() async {
    _checkInitialized();

    KeyPair keyPair = utils!.generateKeyPair();
    return await _setPrivateKey(keyPair);
  }

  @override
  Future<String> generateSharedKey(
    String selfPublicKey,
    String peerPublicKey, {
    String? overrideTopic,
  }) async {
    _checkInitialized();

    String privKey = _getPrivateKey(selfPublicKey);
    String symKey = await utils!.deriveSymKey(privKey, peerPublicKey);
    return await setSymKey(symKey, overrideTopic: overrideTopic);
  }

  @override
  Future<String> setSymKey(
    String symKey, {
    String? overrideTopic,
  }) async {
    _checkInitialized();

    final String topic =
        overrideTopic == null ? utils!.hashKey(symKey) : overrideTopic;
    await keyChain!.set(topic, symKey);
    return topic;
  }

  @override
  Future<void> deleteKeyPair(String publicKey) async {
    _checkInitialized();
    await keyChain!.delete(publicKey);
  }

  @override
  Future<void> deleteSymKey(String topic) async {
    _checkInitialized();
    await keyChain!.delete(topic);
  }

  @override
  Future<String> encode(
    String topic,
    Map<String, dynamic> payload, {
    EncodeOptions? options,
  }) async {
    _checkInitialized();

    EncodingValidation params;
    if (options == null) {
      params = utils!.validateEncoding();
    } else {
      params = utils!.validateEncoding(
        type: options.type,
        senderPublicKey: options.senderPublicKey,
        receiverPublicKey: options.receiverPublicKey,
      );
    }

    final String message = jsonEncode(payload);

    if (utils!.isTypeOneEnvelope(params)) {
      final String selfPublicKey = params.senderPublicKey!;
      final String peerPublicKey = params.receiverPublicKey!;
      topic = await generateSharedKey(selfPublicKey, peerPublicKey);
    }

    final String symKey = _getSymKey(topic);
    final String result = await utils!.encrypt(
      message,
      symKey,
      type: params.type,
      senderPublicKey: params.senderPublicKey,
    );

    return result;
  }

  @override
  Future<String> decode(
    String topic,
    String encoded, {
    DecodeOptions? options,
  }) async {
    _checkInitialized();

    EncodingValidation params;
    if (options == null) {
      params = utils!.validateDecoding(
        encoded,
      );
    } else {
      params = utils!.validateDecoding(
        encoded,
        receiverPublicKey: options.receiverPublicKey,
      );
    }

    if (utils!.isTypeOneEnvelope(params)) {
      final String selfPublicKey = params.senderPublicKey!;
      final String peerPublicKey = params.receiverPublicKey!;
      topic = await generateSharedKey(selfPublicKey, peerPublicKey);
    }
    final String symKey = _getSymKey(topic);
    final String message = await utils!.decrypt(symKey, encoded);

    return message;
  }

  @override
  Future<String> signJWT(String aud) {
    _checkInitialized();
    // TODO: implement signJWT
    throw UnimplementedError();
  }

  @override
  int getPayloadType(String encoded) {
    _checkInitialized();

    return utils!.deserialize(encoded).type;
  }

  List<int> getClientSeed() {
    return [];
  }

  // PRIVATE FUNCTIONS

  Future<String> _setPrivateKey(KeyPair keyPair) async {
    await keyChain!.set(keyPair.publicKey, keyPair.privateKey);
    return keyPair.publicKey;
  }

  String _getPrivateKey(String publicKey) {
    return keyChain!.get(publicKey);
  }

  String _getSymKey(String topic) {
    return keyChain!.get(topic);
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}
