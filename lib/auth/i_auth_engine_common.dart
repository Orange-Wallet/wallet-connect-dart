import 'package:wallet_connect/core/store/i_generic_store.dart';
import 'package:wallet_connect/core/i_core.dart';
import 'package:wallet_connect/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect/models/auth/auth_client_models.dart';

abstract class IAuthEngineCommon {
  abstract final ICore core;
  abstract final PairingMetadata metadata;

  abstract final IGenericStore<AuthPublicKey> authKeys;
  abstract final IGenericStore<String> pairingTopics;
  abstract final IGenericStore<StoredCacao> completeRequests;

  // initializes the client with persisted storage and a network connection
  Future<void> init();

  /// format payload to message string
  String formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  });

  Map<int, StoredCacao> getCompletedRequestsForPairing({
    required String pairingTopic,
  });
}
