import 'package:event/event.dart';

import 'package:wallet_connect/auth/auth_engine.dart';
import 'package:wallet_connect/auth/i_auth_engine.dart';
import 'package:wallet_connect/core/core.dart';
import 'package:wallet_connect/core/i_core.dart';
import 'package:wallet_connect/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect/core/relay_client/relay_client_models.dart';
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
import 'package:wallet_connect/utils/constants/method.dart';
import 'package:wallet_connect/web3app/i_web3app.dart';
import 'package:wallet_connect/utils/constants/constants.dart';


class Web3App implements IWeb3App {
  static const List<List<String>> DEFAULT_METHODS = [
    [
      MethodConstants.WC_SESSION_PROPOSE,
      MethodConstants.WC_SESSION_REQUEST,
    ],
    [
      MethodConstants.WC_AUTH_REQUEST,
    ]
  ];

  bool _initialized = false;

  static Future<Web3App> createInstance({
    required String projectId,
    String relayUrl = DEFAULT_RELAY_URL,
    required PairingMetadata metadata,
    bool memoryStore = false,
  }) async {
    final client = Web3App(
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

  Web3App({
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
    if (_initialized) {
      return;
    }

    await core.start();
    await signEngine.init();
    await authEngine.init();

    _initialized = true;
  }

  ///---------- SIGN ENGINE ----------///

  @override
  Event<SessionConnect> get onSessionConnect => signEngine.onSessionConnect;
  @override
  Event<SessionEvent> get onSessionEvent => signEngine.onSessionEvent;
  @override
  Event<SessionExpire> get onSessionExpire => signEngine.onSessionExpire;
  @override
  Event<SessionProposalEvent> get onProposalExpire =>
      signEngine.onProposalExpire;
  @override
  Event<SessionExtend> get onSessionExtend => signEngine.onSessionExtend;
  @override
  Event<SessionPing> get onSessionPing => signEngine.onSessionPing;
  @override
  Event<SessionUpdate> get onSessionUpdate => signEngine.onSessionUpdate;
  @override
  Event<SessionDelete> get onSessionDelete => signEngine.onSessionDelete;

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
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods = DEFAULT_METHODS,
  }) async {
    try {
      return await signEngine.connect(
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
  Future request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  }) async {
    try {
      return await signEngine.request(
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
    void Function(String, dynamic)? handler,
  }) {
    try {
      return signEngine.registerEventHandler(
        chainId: chainId,
        event: event,
        handler: handler,
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
      return await signEngine.ping(topic: topic);
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
  IPairingStore get pairings => core.pairing.getStore();

  ///---------- AUTH ENGINE ----------///
  @override
  Event<AuthResponse> get onAuthResponse => authEngine.onAuthResponse;

  @override
  IGenericStore<AuthPublicKey> get authKeys => authEngine.authKeys;
  @override
  IGenericStore<String> get pairingTopics => authEngine.pairingTopics;
  @override
  IGenericStore<StoredCacao> get completeRequests =>
      authEngine.completeRequests;

  @override
  late IAuthEngine authEngine;

  @override
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods = DEFAULT_METHODS,
  }) async {
    try {
      return authEngine.requestAuth(
        params: params,
        pairingTopic: pairingTopic,
        methods: methods,
      );
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
