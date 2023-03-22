import 'package:event/event.dart';

import 'package:wallet_connect/core/i_core.dart';
import 'package:wallet_connect/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect/core/store/i_generic_store.dart';
import 'package:wallet_connect/models/basic_models.dart';
import 'package:wallet_connect/sign/i_sessions.dart';
import 'package:wallet_connect/sign/models/proposal_models.dart';
import 'package:wallet_connect/sign/models/session_models.dart';
import 'package:wallet_connect/sign/models/sign_client_events.dart';

abstract class ISignEngineCommon {
  abstract final Event<SessionConnect> onSessionConnect;
  abstract final Event<SessionDelete> onSessionDelete;
  abstract final Event<SessionExpire> onSessionExpire;
  abstract final Event<SessionPing> onSessionPing;
  abstract final Event<SessionProposalEvent> onProposalExpire;

  abstract final ICore core;
  abstract final PairingMetadata metadata;
  abstract final IGenericStore<ProposalData> proposals;
  abstract final ISessions sessions;
  abstract final IGenericStore<SessionRequest> pendingRequests;

  Future<void> init();
  Future<void> disconnectSession({
    required String topic,
    required WalletConnectError reason,
  });
  Map<String, SessionData> getActiveSessions();
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  });
  Map<String, ProposalData> getPendingSessionProposals();
  abstract final IPairingStore pairings;
}
