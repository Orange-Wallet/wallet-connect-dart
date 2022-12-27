import 'package:event/event.dart';
import 'package:wallet_connect_v2/apis/core/i_core.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/i_engine.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/session_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/sign_client_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/signing_models.dart';

abstract class ISignClient {
  final String protocol = 'wc';
  final int version = 2;

  abstract Event<SessionProposal> onSessionProposal;
  abstract Event<SessionUpdate> onSessionUpdate;
  abstract Event<SessionExtend> onSessionExtend;
  abstract Event<SessionPing> onSessionPing;
  abstract Event<SessionDelete> onSessionDelete;
  abstract Event<SessionExpire> onSessionExpire;
  abstract Event<SessionRequest> onSessionRequest;
  abstract Event<SessionEvent> onSessionEvent;
  abstract Event<ProposalExpire> onProposalExpire;

  abstract ICore core;
  abstract IEngine engine;

  Future<void> init();
  Future<ConnectResponse> connect(ConnectParams params);
  Future<PairingInfo> pair(PairParams params);
  Future<ApproveResponse> approve(ApproveParams params);
  Future<void> reject(RejectParams params);
  Future<Future<void>> update(UpdateParams params);
  Future<Future<void>> extend(ExtendParams params);
  Future<T> request<T>(RequestParams params);
  Future<void> respond(RespondParams params);
  Future<void> emit(EmitParams params);
  Future<void> ping(PingParams params);
  Future<void> disconnect(DisconnectParams params);
  SessionData find(FindParams params);
}
