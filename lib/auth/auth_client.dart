import 'package:event/event.dart';

import 'package:wallet_connect/auth/auth_engine.dart';
import 'package:wallet_connect/auth/i_auth_client.dart';
import 'package:wallet_connect/auth/i_auth_engine.dart';
import 'package:wallet_connect/core/core.dart';
import 'package:wallet_connect/core/i_core.dart';
import 'package:wallet_connect/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect/core/store/generic_store.dart';
import 'package:wallet_connect/core/store/i_generic_store.dart';
import 'package:wallet_connect/models/auth/auth_client_events.dart';
import 'package:wallet_connect/models/auth/auth_client_models.dart';
import 'package:wallet_connect/models/basic_models.dart';
import 'package:wallet_connect/utils/constants/constants.dart';

class AuthClient implements IAuthClient {
  bool _initialized = false;

  @override
  String get protocol => 'wc';

  @override
  int get version => 2;

  @override
  Event<AuthRequest> get onAuthRequest => engine.onAuthRequest;
  @override
  Event<AuthResponse> get onAuthResponse => engine.onAuthResponse;

  @override
  ICore get core => engine.core;
  @override
  PairingMetadata get metadata => engine.metadata;
  @override
  IGenericStore<AuthPublicKey> get authKeys => engine.authKeys;
  @override
  IGenericStore<String> get pairingTopics => engine.pairingTopics;
  @override
  IGenericStore<PendingAuthRequest> get authRequests => engine.authRequests;
  @override
  IGenericStore<StoredCacao> get completeRequests => engine.completeRequests;

  @override
  late IAuthEngine engine;

  static Future<AuthClient> createInstance({
    required String projectId,
    String relayUrl = DEFAULT_RELAY_URL,
    required PairingMetadata metadata,
    bool memoryStore = false
  }) async {
    final client = AuthClient(
      core: Core(
        projectId: projectId,
        relayUrl: relayUrl,
        memoryStore: memoryStore
      ),
      metadata: metadata,
    );
    await client.init();

    return client;
  }

  AuthClient({required ICore core, required PairingMetadata metadata}) {
    engine = AuthEngine(
      core: core,
      metadata: metadata,
      authKeys: GenericStore(
        core: core,
        context: CONTEXT_AUTH_KEYS,
        version: VERSION_AUTH_KEYS,
        toJson: (AuthPublicKey value) => value.toJson(),
        fromJson: (dynamic value) => AuthPublicKey.fromJson(value)
      ),
      pairingTopics: GenericStore(
        core: core,
        context: CONTEXT_PAIRING_TOPICS,
        version: VERSION_PAIRING_TOPICS,
        toJson: (String value) => value,
        fromJson: (dynamic value) => value as String
      ),
      authRequests: GenericStore(
        core: core,
        context: CONTEXT_AUTH_REQUESTS,
        version: VERSION_AUTH_REQUESTS,
        toJson: (PendingAuthRequest value) => value.toJson(),
        fromJson: (dynamic value) => PendingAuthRequest.fromJson(value)
      ),
      completeRequests: GenericStore(
        core: core,
        context: CONTEXT_COMPLETE_REQUESTS,
        version: VERSION_COMPLETE_REQUESTS,
        toJson: (StoredCacao value) => value.toJson(),
        fromJson: (dynamic value) => StoredCacao.fromJson(value),
      ),
    );
  }

  @override
  Future<void> init() async {
    if (_initialized) return;

    await core.start();
    await engine.init();

    _initialized = true;
  }

  @override
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods = AuthEngine.DEFAULT_METHODS,
  }) async {
    try {
      return engine.requestAuth(
        params: params,
        pairingTopic: pairingTopic,
        methods: methods,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> respondAuthRequest({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WalletConnectError? error,
  }) async {
    try {
      return engine.respondAuthRequest(
        id: id,
        iss: iss,
        signature: signature,
        error: error,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<int, PendingAuthRequest> getPendingAuthRequests() {
    try {
      return engine.getPendingAuthRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<int, StoredCacao> getCompletedRequestsForPairing({
    required String pairingTopic,
  }) {
    try {
      return engine.getCompletedRequestsForPairing(
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  String formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  }) {
    try {
      return engine.formatAuthMessage(
        iss: iss,
        cacaoPayload: cacaoPayload,
      );
    } catch (e) {
      rethrow;
    }
  }
}
