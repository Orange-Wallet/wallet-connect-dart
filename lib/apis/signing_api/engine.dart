import 'dart:async';

import 'package:event/event.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/pairing_utils.dart';
import 'package:wallet_connect_v2_dart/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2_dart/apis/core/i_core.dart';
import 'package:wallet_connect_v2_dart/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2_dart/apis/models/json_rpc_error.dart';
import 'package:wallet_connect_v2_dart/apis/models/json_rpc_request.dart';
import 'package:wallet_connect_v2_dart/apis/models/basic_errors.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/i_engine.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/generic_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/json_rpc_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/sign_client_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/session_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/i_sessions.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/i_proposals.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/models/signing_models.dart';
import 'package:wallet_connect_v2_dart/apis/signing_api/utils/validator_utils.dart';
import 'package:wallet_connect_v2_dart/apis/utils/constants.dart';
import 'package:wallet_connect_v2_dart/apis/utils/errors.dart';
import 'package:wallet_connect_v2_dart/apis/utils/wallet_connect_utils.dart';

class Engine implements IEngine {
  bool _initialized = false;

  @override
  final Event<SessionDelete> onSessionDelete = Event<SessionDelete>();

  @override
  final Event<SessionConnect> onSessionConnect = Event<SessionConnect>();

  @override
  final Event<SessionEvent> onSessionEvent = Event<SessionEvent>();

  @override
  final Event<SessionExpire> onSessionExpire = Event<SessionExpire>();

  @override
  final Event<SessionExtend> onSessionExtend = Event<SessionExtend>();

  @override
  final Event<SessionPing> onSessionPing = Event<SessionPing>();

  @override
  final Event<SessionProposal> onSessionProposal = Event<SessionProposal>();

  @override
  final Event<SessionRequest> onSessionRequest = Event<SessionRequest>();

  @override
  final Event<SessionUpdate> onSessionUpdate = Event<SessionUpdate>();

  @override
  ICore core;
  @override
  IProposals proposals;
  @override
  ISessions sessions;

  // Map<int, ConnectResponse> pendingProposals = {};
  Map<int, SessionProposalCompleter> pendingProposals = {};
  // Map<int, Function(SessionConnect?)> pendingProposalSubs = {};

  late PairingMetadata selfMetadata;

  Engine(
    this.core,
    this.proposals,
    this.sessions, {
    PairingMetadata? selfMetadata,
  }) {
    if (selfMetadata == null) {
      this.selfMetadata = PairingMetadata('', '', '', []);
    } else {
      this.selfMetadata = selfMetadata;
    }
  }

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.pairing.init();
    await proposals.init();
    await sessions.init();
    _registerExpirerEvents();
    _registerRelayClientFunctions();

    _initialized = true;
  }

  @override
  Future<ConnectResponse> connect({
    required Map<String, RequiredNamespace> requiredNamespaces,
    String? pairingTopic,
    List<Relay>? relays,
  }) async {
    _checkInitialized();

    await _isValidConnect(
      requiredNamespaces,
      pairingTopic,
      relays,
    );
    String? topic = pairingTopic;
    Uri? uri;
    bool active = false;

    if (topic != null) {
      final PairingInfo pairing = core.pairing.getStore().get(topic)!;
      active = pairing.active;
    }

    if (topic == null || !active) {
      final CreateResponse newTopicAndUri = await core.pairing.create();
      topic = newTopicAndUri.topic;
      uri = newTopicAndUri.uri;
      // print('connect generated topic: $topic');
    }

    final publicKey = await core.crypto.generateKeyPair();
    final int id = PairingUtils.payloadId();

    final WcSessionProposeRequest request = WcSessionProposeRequest(
      relays: relays == null
          ? [Relay(WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL)]
          : relays,
      requiredNamespaces: requiredNamespaces,
      proposer: ConnectionMetadata(
        publicKey: publicKey,
        metadata: selfMetadata,
      ),
    );

    final expiry = WalletConnectUtils.calculateExpiry(
      WalletConnectConstants.FIVE_MINUTES,
    );
    final ProposalData proposal = ProposalData(
      id: id,
      expiry: expiry,
      relays: request.relays,
      proposer: request.proposer,
      requiredNamespaces: request.requiredNamespaces,
      pairingTopic: topic,
    );
    await _setProposal(
      id,
      proposal,
    );

    Completer completer = Completer.sync();

    pendingProposals[id] = SessionProposalCompleter(
      publicKey,
      topic,
      request.requiredNamespaces,
      completer,
    );
    connectResponseHandler(
      topic,
      request,
      id,
    );

    final ConnectResponse resp = ConnectResponse(
      session: completer,
      uri: uri,
    );

    return resp;
  }

  Future<void> connectResponseHandler(
    String topic,
    WcSessionProposeRequest request,
    int requestId,
  ) async {
    // print("sending proposal for $topic");
    // print('connectResponseHandler requestId: $requestId');
    final Map<String, dynamic> resp = await core.pairing.sendRequest(
      topic,
      'wc_sessionPropose',
      request.toJson(),
      id: requestId,
    );
    final String peerPublicKey = resp['responderPublicKey'];

    final ProposalData proposal = proposals.get(
      requestId.toString(),
    )!;
    final String sessionTopic = await core.crypto.generateSharedKey(
      proposal.proposer.publicKey,
      peerPublicKey,
    );
    // print('connectResponseHandler session topic: $sessionTopic');

    // Delete the proposal, we are done with it
    await _deleteProposal(requestId);

    await core.relayClient.subscribe(sessionTopic);
    await core.pairing.activate(topic);
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
  }) async {
    _checkInitialized();

    return await core.pairing.pair(uri);
  }

  /// Approves a proposal with the id provided in the parameters.
  /// Assumes the proposal is already created.
  @override
  Future<ApproveResponse> approve({
    required int id,
    required Map<String, Namespace> namespaces,
    String? relayProtocol,
  }) async {
    _checkInitialized();

    await _isValidApprove(
      id,
      namespaces,
      relayProtocol,
    );
    final ProposalData proposal = proposals.get(
      id.toString(),
    )!;

    final String selfPubKey = await core.crypto.generateKeyPair();
    final String peerPubKey = proposal.proposer.publicKey;
    final String sessionTopic = await core.crypto.generateSharedKey(
      selfPubKey,
      peerPubKey,
    );
    // print('approve session topic: $sessionTopic');
    final relay = Relay(
      relayProtocol != null ? relayProtocol! : 'irn',
    );
    final int expiry = WalletConnectUtils.calculateExpiry(
      WalletConnectConstants.SEVEN_DAYS,
    );
    final request = WcSessionSettleRequest(
      id: id,
      relay: relay,
      namespaces: namespaces,
      requiredNamespaces: proposal.requiredNamespaces,
      expiry: expiry,
      controller: ConnectionMetadata(
        publicKey: selfPubKey,
        metadata: selfMetadata,
      ),
    );

    // If we received this request from somewhere, respond with the sessionTopic
    // so they can update their listener.
    // print('approve requestId: ${id}');

    if (proposal.pairingTopic != null && id > 0) {
      // print('approve proposal topic: ${proposal.pairingTopic!}');
      await core.pairing.sendResult(
        id,
        proposal.pairingTopic!,
        'wc_sessionPropose',
        WcSessionProposeResponse(
          relay: Relay(
            relayProtocol != null
                ? relayProtocol
                : WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL,
          ),
          responderPublicKey: selfPubKey,
        ).toJson(),
      );
      await _deleteProposal(id);
      await core.pairing.activate(proposal.pairingTopic!);

      await core.pairing.updateMetadata(
        proposal.pairingTopic!,
        proposal.proposer.metadata,
      );
    }

    await core.relayClient.subscribe(sessionTopic);
    bool acknowledged = await core.pairing.sendRequest(
      sessionTopic,
      'wc_sessionSettle',
      request.toJson(),
    );

    SessionData session = SessionData(
      topic: sessionTopic,
      relay: relay,
      expiry: expiry,
      acknowledged: acknowledged,
      controller: selfPubKey,
      namespaces: namespaces,
      self: ConnectionMetadata(
        publicKey: selfPubKey,
        metadata: selfMetadata,
      ),
      peer: proposal.proposer,
    );

    await sessions.set(sessionTopic, session);

    // If we have a pairing topic, update its metadata with the peer
    if (proposal.pairingTopic != null) {}

    return ApproveResponse(
      topic: sessionTopic,
      session: session,
    );
  }

  @override
  Future<void> reject({
    required int id,
    required ErrorResponse reason,
  }) async {
    _checkInitialized();

    await _isValidReject(id, reason);

    ProposalData? proposal = proposals.get(id.toString());
    if (proposal != null && proposal.pairingTopic != null) {
      await core.pairing.sendError(
        id,
        proposal.pairingTopic!,
        'wc_sessionPropose',
        JsonRpcError.serverError('User rejected request'),
      );
      await _deleteProposal(id);
    }
  }

  @override
  Future<void> update({
    required String topic,
    required Map<String, Namespace> namespaces,
  }) async {
    _checkInitialized();
    await _isValidUpdate(
      topic,
      namespaces,
    );

    await sessions.update(
      topic,
      namespaces: namespaces,
    );

    await core.pairing.sendRequest(
      topic,
      'wc_sessionUpdate',
      WcSessionUpdateRequest(namespaces: namespaces).toJson(),
    );
  }

  @override
  Future<void> extend({
    required String topic,
  }) async {
    _checkInitialized();
    await _isValidSessionTopic(topic);

    await core.pairing.sendRequest(
      topic,
      'wc_sessionUpdate',
      {},
    );

    await _setExpiry(
      topic,
      WalletConnectUtils.calculateExpiry(
        WalletConnectConstants.SEVEN_DAYS,
      ),
    );
  }

  /// Maps a request using chainId:method to its handler
  Map<String, dynamic Function(dynamic)> requestHandlers = {};

  String getRequestMethodKey(String namespace, String method) {
    return '$namespace:$method';
  }

  void registerRequestHandler({
    required String chainId,
    required String method,
    required dynamic Function(dynamic) handler,
  }) {
    _checkInitialized();
    requestHandlers[getRequestMethodKey(chainId, method)] = handler;
  }

  @override
  Future request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  }) async {
    _checkInitialized();
    await _isValidRequest(
      topic,
      chainId,
      request,
    );
    Map<String, dynamic> payload = WcSessionRequestRequest(
      chainId: chainId,
      request: request,
    ).toJson();
    request.toJson();
    return await core.pairing.sendRequest(
      topic,
      'wc_sessionRequest',
      payload,
    );
  }

  @override
  Future<void> ping({
    required String topic,
  }) async {
    _checkInitialized();
    await _isValidPing(topic);

    if (sessions.has(topic)) {
      bool pong = await core.pairing.sendRequest(
        topic,
        'wc_sessionPing',
        {},
      );
    } else if (core.pairing.getStore().has(topic)) {
      await core.pairing.ping(topic);
    }
  }

  @override
  Future<void> emit({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  }) async {
    _checkInitialized();
    await _isValidEmit(
      topic,
      event,
      chainId,
    );
    Map<String, dynamic> payload = WcSessionEventRequest(
      chainId: chainId,
      event: event,
    ).toJson();
    await core.pairing.sendRequest(
      topic,
      'wc_sessionEvent',
      payload,
    );
  }

  @override
  Future<void> disconnect({
    required String topic,
    required ErrorResponse reason,
  }) async {
    _checkInitialized();
    _isValidDisconnect(topic);

    if (sessions.has(topic)) {
      await core.pairing.sendRequest(
        topic,
        "wc_sessionDelete",
        Errors.getSdkError(Errors.USER_DISCONNECTED).toJson(),
      );
      await _deleteSession(topic);
    } else {
      await core.pairing.disconnect(topic);
    }
  }

  @override
  SessionData find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  }) {
    _checkInitialized();
    return sessions.getAll().firstWhere(
      (element) {
        return ValidatorUtils.isSessionCompatible(element, requiredNamespaces);
      },
    );
  }

  /// ---- PRIVATE HELPERS ---- ////
  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }

  Future<void> _deleteSession(
    String topic, {
    bool expirerHasDeleted = false,
  }) async {
    final SessionData? session = sessions.get(topic);
    if (session == null) {
      return;
    }
    await core.relayClient.unsubscribe(topic);
    await Future.wait([
      sessions.delete(topic),
      core.crypto.deleteKeyPair(session.self.publicKey),
      core.crypto.deleteSymKey(topic),
      expirerHasDeleted ? Future.value() : core.expirer.delete(topic),
    ]);
  }

  Future<void> _deleteProposal(
    int id, {
    bool expirerHasDeleted = false,
  }) async {
    await Future.wait([
      proposals.delete(id.toString()),
      expirerHasDeleted ? Future.value() : core.expirer.delete(id.toString()),
    ]);
  }

  Future<void> _setExpiry(String topic, int expiry) async {
    if (sessions.has(topic)) {
      await sessions.update(
        topic,
        expiry: expiry,
      );
    }
    core.expirer.set(topic, expiry);
  }

  Future<void> _setProposal(int id, ProposalData proposal) async {
    await proposals.set(id.toString(), proposal);
    core.expirer.set(id.toString(), proposal.expiry);
  }

  Future<void> _cleanup() async {
    final List<String> sessionTopics = [];
    final List<int> proposalIds = [];

    for (final SessionData session in sessions.getAll()) {
      if (WalletConnectUtils.isExpired(session.expiry)) {
        sessionTopics.add(session.topic);
      }
    }
    for (final ProposalData proposal in proposals.getAll()) {
      if (WalletConnectUtils.isExpired(proposal.expiry)) {
        proposalIds.add(proposal.id);
      }
    }
    await Future.wait([
      ...sessionTopics.map((topic) => _deleteSession(topic)),
      ...proposalIds.map((id) => _deleteProposal(id)),
    ]);
  }

  /// ---- Relay Events ---- ///

  void _registerRelayClientFunctions() {
    core.pairing.register('wc_sessionPropose', _onSessionProposeRequest);
    core.pairing.register('wc_sessionSettle', _onSessionSettleRequest);
    core.pairing.register('wc_sessionUpdate', _onSessionUpdateRequest);
    core.pairing.register('wc_sessionExtend', _onSessionExtendRequest);
    core.pairing.register('wc_sessionPing', _onSessionPingRequest);
    core.pairing.register('wc_sessionDelete', _onSessionDeleteRequest);
    core.pairing.register('wc_sessionRequest', _onSessionRequest);
    core.pairing.register('wc_sessionEvent', _onSessionEventRequest);
  }

  Future<void> _onSessionProposeRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      print(payload.params);
      final proposeRequest = WcSessionProposeRequest.fromJson(payload.params);
      await _isValidConnect(
        proposeRequest.requiredNamespaces,
        topic,
        proposeRequest.relays,
      );
      final expiry = WalletConnectUtils.calculateExpiry(
        WalletConnectConstants.FIVE_MINUTES,
      );
      final ProposalData proposal = ProposalData(
        id: payload.id,
        expiry: expiry,
        relays: proposeRequest.relays,
        proposer: proposeRequest.proposer,
        requiredNamespaces: proposeRequest.requiredNamespaces,
        pairingTopic: topic,
      );

      await _setProposal(payload.id, proposal);
      onSessionProposal.broadcast(SessionProposal(
        payload.id,
        proposal,
      ));
    } on Error catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  Future<void> _onSessionSettleRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    // print('wc session settle');
    final request = WcSessionSettleRequest.fromJson(payload.params);
    try {
      await _isValidSessionSettleRequest(request.namespaces, request.expiry);
      SessionProposalCompleter sProposalCompleter =
          pendingProposals.remove(request.id)!;

      // Create the session
      final SessionData session = SessionData(
        topic: topic,
        relay: request.relay,
        expiry: request.expiry,
        acknowledged: true,
        controller: request.controller.publicKey,
        namespaces: request.namespaces,
        self: ConnectionMetadata(
          publicKey: sProposalCompleter.selfPublicKey,
          metadata: selfMetadata,
        ),
        peer: request.controller,
        requiredNamespaces: sProposalCompleter.requiredNamespaces,
      );

      // Update all the things: session, expiry, metadata, pairing
      sessions.set(topic, session);
      _setExpiry(topic, session.expiry);
      await core.pairing.updateMetadata(
        sProposalCompleter.pairingTopic,
        request.controller.metadata,
      );
      await core.pairing.activate(topic);

      // Send the session back to the completer
      sProposalCompleter.completer.complete(session);

      // Send back a success!
      await core.pairing.sendResult(
        payload.id,
        topic,
        'wc_sessionSettle',
        true,
      );
      onSessionConnect.broadcast(
        SessionConnect(session),
      );
    } on Error catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  Future<void> _onSessionUpdateRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      // print(payload.params);
      final request = WcSessionUpdateRequest.fromJson(payload.params);
      await _isValidUpdate(topic, request.namespaces);
      await sessions.update(
        topic,
        namespaces: request.namespaces,
      );
      await core.pairing.sendResult(
        payload.id,
        topic,
        'wc_sessionUpdate',
        true,
      );
      onSessionUpdate.broadcast(
        SessionUpdate(
          payload.id,
          topic,
          request.namespaces,
        ),
      );
    } on Error catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  Future<void> _onSessionExtendRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      final request = WcSessionExtendRequest.fromJson(payload.params);
      await _isValidSessionTopic(topic);
      await _setExpiry(
        topic,
        WalletConnectUtils.calculateExpiry(
          WalletConnectConstants.SEVEN_DAYS,
        ),
      );
      await core.pairing.sendResult(
        payload.id,
        topic,
        'wc_sessionExtend',
        true,
      );
      onSessionExtend.broadcast(
        SessionExtend(
          payload.id,
          topic,
        ),
      );
    } on Error catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  Future<void> _onSessionPingRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      final request = WcSessionPingRequest.fromJson(payload.params);
      await _isValidPing(topic);
      await core.pairing.sendResult(
        payload.id,
        topic,
        'wc_sessionPing',
        true,
      );
      onSessionPing.broadcast(
        SessionPing(
          payload.id,
          topic,
        ),
      );
    } on Error catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  Future<void> _onSessionDeleteRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      final request = WcSessionDeleteRequest.fromJson(payload.params);
      await _isValidDisconnect(topic);
      await _deleteSession(topic);
      await core.pairing.sendResult(
        payload.id,
        topic,
        'wc_sessionDelete',
        true,
      );
      onSessionDelete.broadcast(
        SessionDelete(
          payload.id,
          topic,
        ),
      );
    } on Error catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  /// Called when a session request is received
  /// Will attempt to find a handler for the request, if it doesn't,
  /// it will throw an error.
  Future<void> _onSessionRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      final request = WcSessionRequestRequest.fromJson(payload.params);
      await _isValidRequest(
        topic,
        request.chainId,
        request.request,
      );

      final String methodKey = getRequestMethodKey(
        request.chainId,
        request.request.method,
      );
      // print('method key: $methodKey');
      if (requestHandlers.containsKey(methodKey)) {
        final handler = requestHandlers[methodKey]!;
        try {
          final result = await handler(
            request.request.params,
          );
          await core.pairing.sendResult(
            payload.id,
            topic,
            'wc_sessionRequest',
            result,
          );
        } catch (err) {
          await core.pairing.sendError(
            payload.id,
            topic,
            payload.method,
            JsonRpcError.invalidParams(
              err.toString(),
            ),
          );
        }
      } else {
        await core.pairing.sendError(
          payload.id,
          topic,
          payload.method,
          JsonRpcError.methodNotFound(
            'No handler found for chainId:method -> ${methodKey}',
          ),
        );
      }

      // onSessionRequest.broadcast(
      //   SessionRequest(
      //     payload.id,
      //     topic,
      //     request.method,
      //     request.chainId,
      //     request.params,
      //   ),
      // );
    } on Error catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  Future<void> _onSessionEventRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      final request = WcSessionEventRequest.fromJson(payload.params);
      final SessionEventParams event = request.event;
      await _isValidEmit(
        topic,
        event,
        request.chainId,
      );
      // await core.pairing.sendResult(
      //   payload.id,
      //   'wc_sessionDelete',
      //   topic,
      //   true,
      // );
      onSessionEvent.broadcast(
        SessionEvent(
          payload.id,
          topic,
          event.name,
          request.chainId,
          event.data,
        ),
      );
    } on Error catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }

  /// ---- Event Registers ---- ///

  void _registerExpirerEvents() {
    core.expirer.expired.subscribe(_onExpired);
  }

  Future<void> _onExpired(ExpirationEvent? event) async {
    if (event == null) {
      return;
    }

    if (sessions.has(event.target)) {
      await _deleteSession(
        event.target,
        expirerHasDeleted: true,
      );
      onSessionExpire.broadcast(
        SessionExpire(
          event.target,
        ),
      );
    } else if (proposals.has(event.target)) {
      await _deleteProposal(
        int.parse(event.target),
        expirerHasDeleted: true,
      );
    }
  }

  /// ---- Validation Helpers ---- ///

  bool _isValidPairingTopic(dynamic topic) {
    if (!core.pairing.getStore().has(topic)) {
      throw Errors.getInternalError(
        "NO_MATCHING_KEY",
        context: "pairing topic doesn't exist: $topic",
      );
    }

    if (WalletConnectUtils.isExpired(
        core.pairing.getStore().get(topic)!.expiry)) {
      // await deletePairing(topic);
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: "pairing topic: $topic",
      );
    }

    return true;
  }

  Future<bool> _isValidSessionTopic(String topic) async {
    if (!sessions.has(topic)) {
      throw Errors.getInternalError(
        "NO_MATCHING_KEY",
        context: "session topic doesn't exist: $topic",
      );
    }

    if (WalletConnectUtils.isExpired(sessions.get(topic)!.expiry)) {
      await _deleteSession(topic);
      throw Errors.getInternalError(
        "EXPIRED",
        context: "session topic: $topic",
      );
    }

    return true;
  }

  Future<bool> _isValidSessionOrPairingTopic(String topic) async {
    if (sessions.has(topic)) {
      await _isValidSessionTopic(topic);
    } else if (core.pairing.getStore().has(topic)) {
      _isValidPairingTopic(topic);
    } else {
      throw Errors.getInternalError(
        "NO_MATCHING_KEY",
        context: "session or pairing topic doesn't exist: $topic",
      );
    }

    return true;
  }

  Future<bool> _isValidProposalId(int id) async {
    if (!proposals.has(id.toString())) {
      throw Errors.getInternalError(
        "NO_MATCHING_KEY",
        context: "proposal id doesn't exist: $id",
      );
    }
    if (WalletConnectUtils.isExpired(proposals.get(id.toString())!.expiry)) {
      await _deleteProposal(id);
      throw Errors.getInternalError(
        "EXPIRED",
        context: "proposal id: $id",
      );
    }

    return true;
  }

  /// ---- Validations ---- ///

  Future<bool> _isValidConnect(
    Map<String, RequiredNamespace> requiredNamespaces,
    String? pairingTopic,
    List<Relay>? relays,
  ) async {
    if (pairingTopic != null) {
      _isValidPairingTopic(pairingTopic);
    }

    return ValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces, "connect()");
  }

  Future<bool> _isValidApprove(
    int id,
    Map<String, Namespace> namespaces,
    String? relayProtocol,
  ) async {
    final ProposalData? proposal = proposals.get(id.toString());
    if (proposal == null) {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: 'No proposal matching id: $id',
      );
    }
    ValidatorUtils.isValidNamespaces(namespaces, "approve()");
    ValidatorUtils.isConformingNamespaces(
        proposal.requiredNamespaces, namespaces, "update()");

    return true;
  }

  Future<bool> _isValidReject(int id, ErrorResponse reason) async {
    return true;
  }

  Future<bool> _isValidSessionSettleRequest(
    Map<String, Namespace> namespaces,
    int expiry,
  ) async {
    ValidatorUtils.isValidNamespaces(namespaces, "onSessionSettleRequest()");
    if (WalletConnectUtils.isExpired(expiry)) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: 'onSessionSettleRequest()',
      );
    }

    return true;
  }

  Future<bool> _isValidUpdate(
    String topic,
    Map<String, Namespace> namespaces,
  ) async {
    await _isValidSessionTopic(topic);
    ValidatorUtils.isValidNamespaces(namespaces, "onSessionSettleRequest()");
    final SessionData session = sessions.get(topic)!;

    ValidatorUtils.isConformingNamespaces(
      session.requiredNamespaces == null ? {} : session.requiredNamespaces!,
      namespaces,
      'update()',
    );

    return true;
  }

  Future<bool> _isValidRequest(
    String topic,
    String chainId,
    SessionRequestParams request,
  ) async {
    await _isValidSessionTopic(topic);
    final SessionData session = sessions.get(topic)!;
    ValidatorUtils.isValidNamespacesChainId(
      session.namespaces,
      chainId,
    );
    ValidatorUtils.isValidNamespacesRequest(
      session.namespaces,
      chainId,
      request.method,
    );

    return true;
  }

  Future<bool> _isValidResponse(
    String topic,
  ) async {
    await _isValidSessionTopic(topic);

    return true;
  }

  Future<bool> _isValidPing(
    String topic,
  ) async {
    await _isValidSessionOrPairingTopic(topic);

    return true;
  }

  Future<bool> _isValidEmit(
    String topic,
    SessionEventParams event,
    String chainId,
  ) async {
    await _isValidSessionTopic(topic);
    final SessionData session = sessions.get(topic)!;
    ValidatorUtils.isValidNamespacesChainId(
      session.namespaces,
      chainId,
    );
    ValidatorUtils.isValidNamespacesEvent(
      session.namespaces,
      chainId,
      event.name,
    );

    return true;
  }

  Future<bool> _isValidDisconnect(
    String topic,
  ) async {
    await _isValidSessionOrPairingTopic(topic);

    return true;
  }
}
