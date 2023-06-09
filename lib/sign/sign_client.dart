import 'package:event/event.dart';

import 'package:wallet_connect/core/core.dart';
import 'package:wallet_connect/core/store/generic_store.dart';
import 'package:wallet_connect/core/store/i_generic_store.dart';
import 'package:wallet_connect/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect/models/basic_models.dart';
import 'package:wallet_connect/sign/sign_engine.dart';
import 'package:wallet_connect/sign/i_sign_engine.dart';
import 'package:wallet_connect/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect/core/i_core.dart';
import 'package:wallet_connect/sign/i_sessions.dart';
import 'package:wallet_connect/sign/i_sign_client.dart';
import 'package:wallet_connect/sign/models/json_rpc_models.dart';
import 'package:wallet_connect/sign/models/proposal_models.dart';
import 'package:wallet_connect/sign/models/sign_client_models.dart';
import 'package:wallet_connect/sign/models/sign_client_events.dart';
import 'package:wallet_connect/sign/models/session_models.dart';
import 'package:wallet_connect/sign/sessions.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_response.dart';
import 'package:wallet_connect/utils/constants/constants.dart';

class SignClient implements ISignClient {
  bool _initialized = false;

  @override
  final String protocol = 'wc';
  @override
  final int version = 2;

  @override
  Event<SessionDelete> get onSessionDelete => engine.onSessionDelete;
  @override
  Event<SessionConnect> get onSessionConnect => engine.onSessionConnect;
  @override
  Event<SessionEvent> get onSessionEvent => engine.onSessionEvent;
  @override
  Event<SessionExpire> get onSessionExpire => engine.onSessionExpire;
  @override
  Event<SessionExtend> get onSessionExtend => engine.onSessionExtend;
  @override
  Event<SessionPing> get onSessionPing => engine.onSessionPing;
  @override
  Event<SessionProposalEvent> get onSessionProposal => engine.onSessionProposal;
  @override
  Event<SessionProposalEvent> get onProposalExpire => engine.onProposalExpire;
  @override
  Event<SessionRequestEvent> get onSessionRequest => engine.onSessionRequest;
  @override
  Event<SessionUpdate> get onSessionUpdate => engine.onSessionUpdate;

  @override
  ICore get core => engine.core;
  @override
  PairingMetadata get metadata => engine.metadata;
  @override
  IGenericStore<ProposalData> get proposals => engine.proposals;
  @override
  ISessions get sessions => engine.sessions;
  @override
  IGenericStore<SessionRequest> get pendingRequests => engine.pendingRequests;

  @override
  late ISignEngine engine;

  static Future<SignClient> createInstance({
    required String projectId,
    String relayUrl = DEFAULT_RELAY_URL,
    required PairingMetadata metadata,
    bool memoryStore = false,
  }) async {
    final client = SignClient(
      core: Core(
        projectId: projectId,
        relayUrl: relayUrl,
        memoryStore: memoryStore,
      ),
      metadata: metadata,
    );
    await client.init();

    return client;
  }

  SignClient({
    required ICore core,
    required PairingMetadata metadata,
  }) {
    engine = SignEngine(
      core: core,
      metadata: metadata,
      proposals: GenericStore(
        core: core,
        context: CONTEXT_PROPOSALS,
        version: VERSION_PROPOSALS,
        toJson: (ProposalData value) {
          return value.toJson();
        },
        fromJson: (dynamic value) {
          return ProposalData.fromJson(value);
        },
      ),
      sessions: Sessions(core),
      pendingRequests: GenericStore(
        core: core,
        context: CONTEXT_PENDING_REQUESTS,
        version: VERSION_PENDING_REQUESTS,
        toJson: (SessionRequest value) {
          return value.toJson();
        },
        fromJson: (dynamic value) {
          return SessionRequest.fromJson(value);
        },
      ),
    );
  }

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.start();
    await engine.init();

    _initialized = true;
  }

  @override
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods = SignEngine.DEFAULT_METHODS,
  }) async {
    try {
      return await engine.connect(
        requiredNamespaces: requiredNamespaces,
        optionalNamespaces: optionalNamespaces,
        sessionProperties: sessionProperties,
        pairingTopic: pairingTopic,
        relays: relays,
        methods: methods,
      );
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
  }) async {
    try {
      return await engine.pair(uri: uri);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    String? relayProtocol,
  }) async {
    try {
      return await engine.approveSession(
        id: id,
        namespaces: namespaces,
        relayProtocol: relayProtocol,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> rejectSession({
    required int id,
    required WalletConnectError reason,
  }) async {
    try {
      return await engine.rejectSession(
        id: id,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateSession({
    required String topic,
    required Map<String, Namespace> namespaces,
  }) async {
    try {
      return await engine.updateSession(
        topic: topic,
        namespaces: namespaces,
      );
    } catch (e) {
      // final error = e as WCError;
      rethrow;
    }
  }

  @override
  Future<void> extendSession({
    required String topic,
  }) async {
    try {
      return await engine.extendSession(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerRequestHandler({
    required String chainId,
    required String method,
    void Function(String, dynamic)? handler,
  }) {
    try {
      return engine.registerRequestHandler(
        chainId: chainId,
        method: method,
        handler: handler,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> respondSessionRequest({
    required String topic,
    required JsonRpcResponse response,
  }) {
    try {
      return engine.respondSessionRequest(
        topic: topic,
        response: response,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  }) async {
    try {
      return await engine.request(
        topic: topic,
        chainId: chainId,
        request: request,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerEventHandler({
    required String chainId,
    required String event,
    dynamic Function(String, dynamic)? handler,
  }) {
    try {
      return engine.registerEventHandler(
        chainId: chainId,
        event: event,
        handler: handler,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> emitSessionEvent({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  }) async {
    try {
      return await engine.emitSessionEvent(
        topic: topic,
        chainId: chainId,
        event: event,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> ping({
    required String topic,
  }) async {
    try {
      return await engine.ping(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> disconnectSession({
    required String topic,
    required WalletConnectError reason,
  }) async {
    try {
      return await engine.disconnectSession(
        topic: topic,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  }) {
    try {
      return engine.find(requiredNamespaces: requiredNamespaces);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getActiveSessions() {
    try {
      return engine.getActiveSessions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  }) {
    try {
      return engine.getSessionsForPairing(
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, ProposalData> getPendingSessionProposals() {
    try {
      return engine.getPendingSessionProposals();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionRequest> getPendingSessionRequests() {
    try {
      return engine.getPendingSessionRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();
}
