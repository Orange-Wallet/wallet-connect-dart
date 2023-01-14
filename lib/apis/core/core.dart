import 'package:wallet_connect_v2_dart/apis/core/crypto/crypto.dart';
import 'package:wallet_connect_v2_dart/apis/core/crypto/i_crypto.dart';
import 'package:wallet_connect_v2_dart/apis/core/i_core.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/expirer.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/i_expirer.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/i_json_rpc_history.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/json_rpc_history.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/pairing.dart';
import 'package:wallet_connect_v2_dart/apis/core/relay_client/relay_client.dart';
import 'package:wallet_connect_v2_dart/apis/core/store/get_storage_store.dart';
import 'package:wallet_connect_v2_dart/apis/core/store/i_store.dart';
import 'package:wallet_connect_v2_dart/apis/core/relay_client/i_relay_client.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/i_pairing.dart';

class Core implements ICore {
  @override
  String get protocol => 'wc';
  @override
  String get version => '2';

  String _relayUrl;
  @override
  String get relayUrl => _relayUrl;
  String _projectId;
  @override
  String get projectId => _projectId;

  @override
  late ICrypto crypto;

  @override
  late IRelayClient relayClient;

  @override
  late IExpirer expirer;

  @override
  late IJsonRpcHistory history;

  @override
  late IPairing pairing;

  @override
  late IStore<Map<String, dynamic>> storage;

  Core(
    this._relayUrl,
    this._projectId, {
    bool memoryStore = false,
  }) {
    storage = GetStorageStore(
      <String, dynamic>{},
      memoryStore: memoryStore,
    );
    crypto = Crypto(this);
    relayClient = RelayClient(this);
    expirer = Expirer(this);
    history = JsonRpcHistory(this);
    pairing = Pairing(this);
  }

  @override
  Future<void> start() async {
    await storage.init();
    await crypto.init();
    await relayClient.init();
    await expirer.init();
    await history.init();
    await pairing.init();
  }
}
