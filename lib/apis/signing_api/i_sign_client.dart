import 'package:event/event.dart';
import 'package:wallet_connect_v2/apis/core/i_core.dart';
import 'package:wallet_connect_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/i_engine.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/session_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/sign_client_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/signing_models.dart';

abstract class ISignClient {
  final String protocol = 'wc';
  final int version = 2;

  abstract final Event<SessionProposal> onSessionProposal;
  abstract final Event<SessionConnect> onSessionConnect;
  abstract final Event<SessionUpdate> onSessionUpdate;
  abstract final Event<SessionExtend> onSessionExtend;
  abstract final Event<SessionPing> onSessionPing;
  abstract final Event<SessionDelete> onSessionDelete;
  abstract final Event<SessionExpire> onSessionExpire;
  abstract final Event<SessionRequest> onSessionRequest;
  abstract final Event<SessionEvent> onSessionEvent;

  abstract ICore core;
  abstract IEngine engine;

  Future<void> init();
  Future<ConnectResponse> connect(ConnectParams params);
  Future<PairingInfo> pair(PairParams params);
  Future<ApproveResponse> approve(ApproveParams params);
  Future<void> reject(RejectParams params);
  Future<void> update(UpdateParams params);
  Future<void> extend(ExtendParams params);
  void registerRequestHandler(
    String chainId,
    String method,
    dynamic Function(dynamic) handler,
  );
  Future<dynamic> request(RequestParams params);
  // Future<void> respond(RespondParams params);
  Future<void> emit(EmitParams params);
  Future<void> ping(PingParams params);
  Future<void> disconnect(DisconnectParams params);
  SessionData find(FindParams params);
  abstract final IPairingStore pairings;
}
