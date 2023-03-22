import 'package:event/event.dart';

import 'package:wallet_connect/auth/i_auth_engine_common.dart';
import 'package:wallet_connect/core/store/i_generic_store.dart';
import 'package:wallet_connect/models/auth/auth_client_events.dart';
import 'package:wallet_connect/models/auth/auth_client_models.dart';
import 'package:wallet_connect/models/basic_models.dart';

abstract class IAuthEngineWallet extends IAuthEngineCommon {
  abstract final Event<AuthRequest> onAuthRequest;

  abstract final IGenericStore<PendingAuthRequest> authRequests;

  // initializes the client with persisted storage and a network connection
  Future<void> init();

  /// respond wallet authentication
  Future<void> respondAuthRequest({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WalletConnectError? error,
  });

  // query all pending requests
  Map<int, PendingAuthRequest> getPendingAuthRequests();
}
