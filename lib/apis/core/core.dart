import 'package:wallet_connect_v2/apis/core/crypto/crypto.dart';
import 'package:wallet_connect_v2/apis/core/crypto/i_crypto.dart';
import 'package:wallet_connect_v2/apis/core/i_core.dart';
import 'package:wallet_connect_v2/apis/core/pairing/expirer.dart';
import 'package:wallet_connect_v2/apis/core/pairing/i_expirer.dart';
import 'package:wallet_connect_v2/apis/core/pairing/i_json_rpc_history.dart';
import 'package:wallet_connect_v2/apis/core/pairing/json_rpc_history.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client.dart';
import 'package:wallet_connect_v2/apis/core/store/get_storage_store.dart';
import 'package:wallet_connect_v2/apis/core/store/i_store.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/i_relay_client.dart';
import 'package:wallet_connect_v2/apis/core/pairing/i_pairing.dart';

class Core implements ICore {
  @override
  // TODO: implement protocol
  String get protocol => throw UnimplementedError();
  @override
  // TODO: implement version
  String get version => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();
  @override
  // TODO: implement context
  String get context => throw UnimplementedError();
  String _relayUrl;
  @override
  String get relayUrl => throw UnimplementedError();
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
    this._projectId,
  ) {
    storage = GetStorageStore();
    crypto = Crypto(this);
    relayClient = RelayClient(this);
    expirer = Expirer(this);
    history = JsonRpcHistory(this);
    // pairing = Pairing(crypto, relayer)
  }

  @override
  Future<void> start() async {
    await storage.init();
    await crypto.init();
    await relayClient.init();
    await history.init();
    // await pairing.init();
  }
}
