import 'package:event/event.dart';
import 'package:wallet_connect_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect_v2/apis/signing_api/engine.dart';
import 'package:wallet_connect_v2/apis/signing_api/i_engine.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2/apis/core/i_core.dart';
import 'package:wallet_connect_v2/apis/signing_api/i_sign_client.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/signing_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/sign_client_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/session_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/proposals.dart';
import 'package:wallet_connect_v2/apis/signing_api/sessions.dart';

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
  Event<SessionProposal> get onSessionProposal => engine.onSessionProposal;

  @override
  Event<SessionRequest> get onSessionRequest => engine.onSessionRequest;

  @override
  Event<SessionUpdate> get onSessionUpdate => engine.onSessionUpdate;

  @override
  ICore core;

  @override
  late IEngine engine;

  static Future<SignClient> createInstance(
    ICore core, {
    PairingMetadata? self,
  }) async {
    final client = SignClient(core, self: self);
    await client.init();

    return client;
  }

  SignClient(
    this.core, {
    PairingMetadata? self,
  }) {
    Proposals p = Proposals(core);
    Sessions s = Sessions(core);
    engine = Engine(
      core,
      p,
      s,
      selfMetadata: self,
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
  Future<ConnectResponse> connect(ConnectParams params) async {
    return await engine.connect(params);
    // try {
    // } catch (e) {
    //   print(e);
    //   throw e;
    // }
  }

  @override
  Future<PairingInfo> pair(PairParams params) async {
    try {
      return await engine.pair(params);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<ApproveResponse> approve(ApproveParams params) async {
    return await engine.approve(params);
    // try {
    // } catch (e) {
    //   throw e;
    // }
  }

  @override
  Future<void> reject(RejectParams params) async {
    try {
      return await engine.reject(params);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> update(UpdateParams params) async {
    try {
      return await engine.update(params);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> extend(ExtendParams params) async {
    try {
      return await engine.extend(params);
    } catch (e) {
      throw e;
    }
  }

  @override
  void registerRequestHandler(
    String chainId,
    String method,
    void Function(dynamic) handler,
  ) {
    try {
      return engine.registerRequestHandler(
        chainId,
        method,
        handler,
      );
    } catch (e) {
      throw e;
    }
  }

  @override
  Future request(RequestParams params) async {
    return await engine.request(params);
    // try {
    // } catch (e) {
    //   throw e;
    // }
  }

  @override
  Future<void> emit(EmitParams params) async {
    try {
      return await engine.emit(params);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> ping(PingParams params) async {
    try {
      return await engine.ping(params);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> disconnect(DisconnectParams params) async {
    try {
      return await engine.disconnect(params);
    } catch (e) {
      throw e;
    }
  }

  @override
  SessionData find(FindParams params) {
    try {
      return engine.find(params);
    } catch (e) {
      throw e;
    }
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();
}
