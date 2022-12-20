import 'dart:convert';

import 'package:wallet_connect_v2/apis/core/crypto/i_crypto.dart';
import 'package:wallet_connect_v2/apis/core/pairing/i_pairing.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/i_relay_client.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2/apis/core/store/store.dart';
import 'package:wallet_connect_v2/apis/utils/constants.dart';
import 'package:wallet_connect_v2/apis/utils/errors.dart';
import 'package:wallet_connect_v2/apis/utils/misc.dart';

class Pairing implements IPairing {
  bool _initialized = false;

  ICrypto crypto;
  IRelayClient relayer;
  Store pairingsStore = Store(WalletConnectConstants.CORE_STORAGE_PREFIX);

  Pairing(
    this.crypto,
    this.relayer,
  );

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await pairingsStore.init();
    _initialized = true;
  }

  @override
  Future<PairingInfo> pair(String uriString, bool? activatePairing) async {
    _checkInitialized();

    final Uri uri = Uri.parse(uriString);
    final int expiry = MiscUtils.calculateExpiry(
      WalletConnectConstants.FIVE_MINUTES,
    );
    final String topic = uri.queryParameters['topic']!;
    final Relay relay = Relay.fromJson(jsonDecode(
      uri.queryParameters['relay']!,
    ));
    final String symKey = uri.queryParameters['symKey']!;
    final PairingInfo pairing = PairingInfo(
      topic,
      expiry,
      relay,
      false,
    );
    await _storePairing(pairing);
    await crypto.setSymKey(symKey, overrideTopic: topic);
    await relayer.subscribe(topic);

    return pairing;
  }

  @override
  Future<CreateResponse> create() {
    _checkInitialized();
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> activate(String topic) {
    _checkInitialized();
    // TODO: implement activate
    throw UnimplementedError();
  }

  @override
  void register(List<String> methods) {
    _checkInitialized();
    // TODO: implement register
  }

  @override
  Future<void> updateExpiry(String topic, int expiry) {
    _checkInitialized();
    // TODO: implement updateExpiry
    throw UnimplementedError();
  }

  @override
  Future<void> updateMetadata(String topic, PairingMetadata metadata) {
    _checkInitialized();
    // TODO: implement updateMetadata
    throw UnimplementedError();
  }

  @override
  List<PairingInfo> getPairings() {
    _checkInitialized();
    return pairingsStore
        .getAll()
        .map(
          (String e) => PairingInfo.fromJson(jsonDecode(e)),
        )
        .toList();
  }

  @override
  Future<void> ping(String topic) {
    _checkInitialized();
    // TODO: implement ping
    throw UnimplementedError();
  }

  @override
  Future<void> disconnect(String topic) {
    _checkInitialized();
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  // PRIVATE FUNCTIONS

  Future<void> _cleanup() async {
    final List<PairingInfo> expiredPairings = getPairings()
        .where(
          (PairingInfo info) => MiscUtils.isExpired(info.expiry),
        )
        .toList();
    expiredPairings.map(
      (PairingInfo e) async => await _deletePairing(e.topic),
    );
    // const expiredPairings = this.pairings.getAll().filter((pairing) => isExpired(pairing.expiry));
    // await Promise.all(expiredPairings.map((pairing) => this.deletePairing(pairing.topic)));
  }

  Future<void> _storePairing(PairingInfo pairing) async {
    await pairingsStore.set(pairing.topic, jsonEncode(pairing.toJson()));
  }

  PairingInfo _getPairing(String topic) {
    return PairingInfo.fromJson(jsonDecode(pairingsStore.get(topic)));
  }

  Future<void> _deletePairing(String topic) async {}

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}
