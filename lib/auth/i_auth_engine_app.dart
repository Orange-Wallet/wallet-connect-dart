import 'package:event/event.dart';

import 'package:wallet_connect/auth/i_auth_engine_common.dart';
import 'package:wallet_connect/models/auth/auth_client_events.dart';
import 'package:wallet_connect/models/auth/auth_client_models.dart';

abstract class IAuthEngineApp extends IAuthEngineCommon {
  abstract final Event<AuthResponse> onAuthResponse;

  // request wallet authentication
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods,
  });
}
