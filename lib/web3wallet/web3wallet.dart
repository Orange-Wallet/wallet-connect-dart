import 'package:event/event.dart';

import 'package:wallet_connect/auth/auth_engine.dart';
import 'package:wallet_connect/auth/i_auth_engine.dart';
import 'package:wallet_connect/core/core.dart';
import 'package:wallet_connect/core/i_core.dart';
import 'package:wallet_connect/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect/core/store/generic_store.dart';
import 'package:wallet_connect/core/store/i_generic_store.dart';
import 'package:wallet_connect/models/auth/auth_client_events.dart';
import 'package:wallet_connect/models/auth/auth_client_models.dart';
import 'package:wallet_connect/models/basic_models.dart';
import 'package:wallet_connect/sign/i_sessions.dart';
import 'package:wallet_connect/sign/i_sign_engine.dart';
import 'package:wallet_connect/sign/models/json_rpc_models.dart';
import 'package:wallet_connect/sign/models/proposal_models.dart';
import 'package:wallet_connect/sign/models/session_models.dart';
import 'package:wallet_connect/sign/models/sign_client_events.dart';
import 'package:wallet_connect/sign/models/sign_client_models.dart';
import 'package:wallet_connect/sign/sessions.dart';
import 'package:wallet_connect/sign/sign_engine.dart';
import 'package:wallet_connect/web3wallet/i_web3wallet.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_response.dart';
import 'package:wallet_connect/utils/constants/constants.dart';

class Web3Wallet implements IWeb3Wallet {
  bool _initialized = false;

  static Future<Web3Wallet> createInstance({
    required String projectId,
    String relayUrl = DEFAULT_RELAY_URL,
    required PairingMetadata metadata,
    bool memoryStore = false
  }) async {
    final client = Web3Wallet(
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

  ///---------- GENERIC ----------///

  @override
  final String protocol = 'wc';
  @override
  final int version = 2;

  @override
  final ICore core;
  @override
  final PairingMetadata metadata;

  Web3Wallet({
    required this.core,
    required this.metadata,
  }) {
    signEngine = SignEngine(
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

    authEngine = AuthEngine(
      core: core,
      metadata: metadata,
      authKeys: GenericStore(
        core: core,
        context: CONTEXT_AUTH_KEYS,
        version: VERSION_AUTH_KEYS,
        toJson: (AuthPublicKey value) {
          return value.toJson();
        },
        fromJson: (dynamic value) {
          return AuthPublicKey.fromJson(value);
        },
      ),
      pairingTopics: GenericStore(
        core: core,
        context: CONTEXT_PAIRING_TOPICS,
        version: VERSION_PAIRING_TOPICS,
        toJson: (String value) {
          return value;
        },
        fromJson: (dynamic value) {
          return value;
        },
      ),
      authRequests: GenericStore(
        core: core,
        context: CONTEXT_AUTH_REQUESTS,
        version: VERSION_AUTH_REQUESTS,
        toJson: (PendingAuthRequest value) {
          return value.toJson();
        },
        fromJson: (dynamic value) {
          return PendingAuthRequest.fromJson(value);
        },
      ),
      completeRequests: GenericStore(
        core: core,
        context: CONTEXT_COMPLETE_REQUESTS,
        version: VERSION_COMPLETE_REQUESTS,
        toJson: (StoredCacao value) {
          return value.toJson();
        },
        fromJson: (dynamic value) {
          return StoredCacao.fromJson(value);
        },
      ),
    );
  }

  @override
  Future<void> init() async {
    if (_initialized) return;

    await core.start();
    await signEngine.init();
    await authEngine.init();

    _initialized = true;
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
  }) async {
    try {
      return await signEngine.pair(uri: uri);
    } catch (e) {
      rethrow;
    }
  }

  ///---------- SIGN ENGINE ----------///

  @override
  Event<SessionConnect> get onSessionConnect => signEngine.onSessionConnect;
  @override
  Event<SessionDelete> get onSessionDelete => signEngine.onSessionDelete;
  @override
  Event<SessionExpire> get onSessionExpire => signEngine.onSessionExpire;
  @override
  Event<SessionProposalEvent> get onSessionProposal =>
      signEngine.onSessionProposal;
  @override
  Event<SessionProposalEvent> get onProposalExpire =>
      signEngine.onProposalExpire;
  @override
  Event<SessionRequestEvent> get onSessionRequest =>
      signEngine.onSessionRequest;
  @override
  Event<SessionPing> get onSessionPing => signEngine.onSessionPing;

  @override
  IGenericStore<ProposalData> get proposals => signEngine.proposals;
  @override
  ISessions get sessions => signEngine.sessions;
  @override
  IGenericStore<SessionRequest> get pendingRequests =>
      signEngine.pendingRequests;

  @override
  late ISignEngine signEngine;

  @override
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    String? relayProtocol,
  }) async {
    try {
      return await signEngine.approveSession(
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
      return await signEngine.rejectSession(
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
      return await signEngine.updateSession(
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
      return await signEngine.extendSession(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerRequestHandler({
    required String chainId,
    required String method,
    dynamic Function(String, dynamic)? handler,
  }) {
    try {
      return signEngine.registerRequestHandler(
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
      return signEngine.respondSessionRequest(
        topic: topic,
        response: response,
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
      return await signEngine.emitSessionEvent(
        topic: topic,
        chainId: chainId,
        event: event,
      );
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
      return await signEngine.disconnectSession(
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
      return signEngine.find(requiredNamespaces: requiredNamespaces);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getActiveSessions() {
    try {
      return signEngine.getActiveSessions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  }) {
    try {
      return signEngine.getSessionsForPairing(
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, ProposalData> getPendingSessionProposals() {
    try {
      return signEngine.getPendingSessionProposals();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionRequest> getPendingSessionRequests() {
    try {
      return signEngine.getPendingSessionRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();

  ///---------- AUTH ENGINE ----------///
  @override
  Event<AuthRequest> get onAuthRequest => authEngine.onAuthRequest;

  @override
  IGenericStore<AuthPublicKey> get authKeys => authEngine.authKeys;
  @override
  IGenericStore<String> get pairingTopics => authEngine.pairingTopics;
  @override
  IGenericStore<PendingAuthRequest> get authRequests => authEngine.authRequests;
  @override
  IGenericStore<StoredCacao> get completeRequests =>
      authEngine.completeRequests;

  @override
  late IAuthEngine authEngine;

  @override
  Future<void> respondAuthRequest({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WalletConnectError? error,
  }) async {
    try {
      return authEngine.respondAuthRequest(
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
      return authEngine.getPendingAuthRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<int, StoredCacao> getCompletedRequestsForPairing({
    required String pairingTopic,
  }) {
    try {
      return authEngine.getCompletedRequestsForPairing(
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
      return authEngine.formatAuthMessage(
        iss: iss,
        cacaoPayload: cacaoPayload,
      );
    } catch (e) {
      rethrow;
    }
  }
}
