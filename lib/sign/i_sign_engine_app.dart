import 'package:event/event.dart';
import 'package:wallet_connect/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect/sign/i_sign_engine_common.dart';
import 'package:wallet_connect/sign/models/json_rpc_models.dart';
import 'package:wallet_connect/sign/models/proposal_models.dart';
import 'package:wallet_connect/sign/models/session_models.dart';
import 'package:wallet_connect/sign/models/sign_client_events.dart';
import 'package:wallet_connect/sign/models/sign_client_models.dart';

abstract class ISignEngineApp extends ISignEngineCommon {
  abstract final Event<SessionUpdate> onSessionUpdate;
  abstract final Event<SessionExtend> onSessionExtend;
  abstract final Event<SessionEvent> onSessionEvent;

  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods,
  });
  Future<dynamic> request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  });
  void registerEventHandler({
    required String chainId,
    required String event,
    required dynamic Function(String, dynamic)? handler,
  });
  Future<void> ping({
    required String topic,
  });
  Map<String, SessionData> getActiveSessions();
  abstract final IPairingStore pairings;
}
