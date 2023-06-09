import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';

import 'package:wallet_connect/core/crypto/crypto_models.dart';
import 'package:wallet_connect/core/crypto/crypto_utils.dart';
import 'package:wallet_connect/core/crypto/i_crypto.dart';
import 'package:wallet_connect/core/crypto/i_crypto_utils.dart';
import 'package:wallet_connect/core/i_core.dart';
import 'package:wallet_connect/core/key_chain/i_key_chain.dart';
import 'package:wallet_connect/core/key_chain/key_chain.dart';
import 'package:wallet_connect/core/relay_auth/i_relay_auth.dart';
import 'package:wallet_connect/core/relay_auth/relay_auth.dart';
import 'package:wallet_connect/core/relay_auth/relay_auth_models.dart';
import 'package:wallet_connect/utils/constants/constants.dart';
import 'package:wallet_connect/utils/constants/errors.dart';

class Crypto implements ICrypto {
  static const CRYPTO_CONTEXT = 'crypto';
  static const CRYPTO_CLIENT_SEED = 'client_ed25519_seed';
  static const CLIENT_SEED = 'CLIENT_SEED';

  bool _initialized = false;

  @override
  String get name => CRYPTO_CONTEXT;

  ICore core;

  @override
  IKeyChain? keyChain;
  ICryptoUtils? utils;
  IRelayAuth? relayAuth;

  Crypto(
    this.core, {
    this.keyChain,
    this.utils,
    this.relayAuth,
  });

  @override
  Future<void> init() async {
    if (_initialized) return;

    if (keyChain == null) keyChain = KeyChain(core);
    if (utils == null) utils = CryptoUtils();
    if (relayAuth == null) relayAuth = RelayAuth();

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

    // If we don't have a pub key associated with the seed yet, make one
    final Uint8List seed = await _getClientSeed();
    final RelayAuthKeyPair keyPair = await relayAuth!.generateKeyPair(seed);
    return relayAuth!.encodeIss(keyPair.publicKeyBytes);
  }

  @override
  Future<String> generateKeyPair() async {
    _checkInitialized();

    CryptoKeyPair keyPair = utils!.generateKeyPair();
    return await _setPrivateKey(keyPair);
  }

  @override
  Future<String> generateSharedKey(
    String selfPublicKey,
    String peerPublicKey, {
    String? overrideTopic,
  }) async {
    _checkInitialized();

    String privKey = _getPrivateKey(selfPublicKey)!;
    String symKey = await utils!.deriveSymKey(privKey, peerPublicKey);
    return await setSymKey(symKey, overrideTopic: overrideTopic);
  }

  @override
  Future<String> setSymKey(
    String symKey, {
    String? overrideTopic,
  }) async {
    _checkInitialized();

    final String topic = overrideTopic == null ? utils!.hashKey(symKey) : overrideTopic;
    // print('crypto setSymKey, symKey: $symKey, overrideTopic: $topic');
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
  Future<String?> encode(
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

    final String? symKey = _getSymKey(topic);
    if (symKey == null) return null;

    final String result = await utils!.encrypt(
      message,
      symKey,
      type: params.type,
      senderPublicKey: params.senderPublicKey,
    );

    return result;
  }

  @override
  Future<String?> decode(
    String topic,
    String encoded, {
    DecodeOptions? options,
  }) async {
    _checkInitialized();

    EncodingValidation params;
    if (options == null) {
      params = utils!.validateDecoding(encoded);
    } else {
      params = utils!.validateDecoding(
        encoded,
        receiverPublicKey: options.receiverPublicKey,
      );
    }

    if (utils!.isTypeOneEnvelope(params)) {
      final String selfPublicKey = params.receiverPublicKey!;
      final String peerPublicKey = params.senderPublicKey!;
      topic = await generateSharedKey(selfPublicKey, peerPublicKey);
    }
    final String? symKey = _getSymKey(topic);
    if (symKey == null) return null;

    final String message = await utils!.decrypt(symKey, encoded);

    return message;
  }

  @override
  Future<String> signJWT(String aud) async {
    _checkInitialized();
    final Uint8List seed = await _getClientSeed();
    final RelayAuthKeyPair keyPair = await relayAuth!.generateKeyPair(seed);
    String sub = utils!.generateRandomBytes32();
    String jwt = await relayAuth!.signJWT(
      sub: sub,
      aud: aud,
      ttl: ONE_DAY,
      keyPair: keyPair,
    );
    return jwt;
  }

  @override
  int getPayloadType(String encoded) {
    _checkInitialized();

    return utils!.deserialize(encoded).type;
  }

  // PRIVATE FUNCTIONS

  Future<String> _setPrivateKey(CryptoKeyPair keyPair) async {
    await keyChain!.set(keyPair.publicKey, keyPair.privateKey);
    return keyPair.publicKey;
  }

  String? _getPrivateKey(String publicKey) {
    return keyChain!.get(publicKey);
  }

  String? _getSymKey(String topic) {
    // print('crypto getSymKey: $topic');
    return keyChain!.get(topic);
  }

  // Future<String> _getClientKeyFromSeed() async {
  //   // Get the seed
  //   String seed = await _getClientSeed();

  //   String pubKey = keyChain!.get(seed);
  //   if (pubKey == '') {
  //     pubKey = await generateKeyPair();
  //     await keyChain!.set(seed, pubKey);
  //   }

  //   return pubKey;
  // }

  Future<Uint8List> _getClientSeed() async {
    String? seed = keyChain!.get(CLIENT_SEED);
    if (seed == null) {
      seed = utils!.generateRandomBytes32();
      await keyChain!.set(CLIENT_SEED, seed);
    }

    return Uint8List.fromList(hex.decode(seed));
  }

  void _checkInitialized() {
    if (!_initialized) throw Errors.getInternalError(Errors.NOT_INITIALIZED);
  }

  @override
  ICryptoUtils getUtils() {
    return utils!;
  }
}
