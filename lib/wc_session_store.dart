import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:wallet_connect/models/session/wc_session.dart';
import 'package:wallet_connect/models/wc_peer_meta.dart';

part 'wc_session_store.freezed.dart';
part 'wc_session_store.g.dart';

@immutable
@freezed
class WCSessionStore with _$WCSessionStore {
  factory WCSessionStore({
    required WCSession session,
    required WCPeerMeta peerMeta,
    required WCPeerMeta remotePeerMeta,
    required int chainId,
    required String peerId,
    required String remotePeerId,
  }) = _WCSessionStore;

  factory WCSessionStore.fromJson(Map<String, dynamic> json) =>
      _$WCSessionStoreFromJson(json);
}
