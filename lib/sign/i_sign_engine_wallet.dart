import 'package:event/event.dart';
import 'package:wallet_connect/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect/models/basic_models.dart';
import 'package:wallet_connect/sign/i_sign_engine_common.dart';
import 'package:wallet_connect/sign/models/json_rpc_models.dart';
import 'package:wallet_connect/sign/models/proposal_models.dart';
import 'package:wallet_connect/sign/models/session_models.dart';
import 'package:wallet_connect/sign/models/sign_client_events.dart';
import 'package:wallet_connect/sign/models/sign_client_models.dart';
import 'package:wallet_connect/models/jsonrpc/json_rpc_response.dart';

abstract class ISignEngineWallet extends ISignEngineCommon {
  abstract final Event<SessionProposalEvent> onSessionProposal;
  abstract final Event<SessionRequestEvent> onSessionRequest;

  Future<PairingInfo> pair({
    required Uri uri,
  });
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    String? relayProtocol,
  });
  Future<void> rejectSession({
    required int id,
    required WalletConnectError reason,
  });
  Future<void> updateSession({
    required String topic,
    required Map<String, Namespace> namespaces,
  });
  Future<void> extendSession({
    required String topic,
  });
  void registerRequestHandler({
    required String chainId,
    required String method,
    dynamic Function(String, dynamic)? handler,
  });
  Future<void> respondSessionRequest({
    required String topic,
    required JsonRpcResponse response,
  });
  Future<void> emitSessionEvent({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  });
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  });
  Map<String, SessionRequest> getPendingSessionRequests();
}
