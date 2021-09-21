import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:wallet_connect/models/wc_peer_meta.dart';

part 'wc_session_request.g.dart';

@JsonSerializable()
class WCSessionRequest {
  final String peerId;
  final WCPeerMeta peerMeta;
  final int chainId;
  WCSessionRequest({
    @required this.peerId,
    @required this.peerMeta,
    this.chainId,
  });

  factory WCSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$WCSessionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$WCSessionRequestToJson(this);

  @override
  String toString() =>
      'WCSessionRequest(peerId: $peerId, peerMeta: $peerMeta, chainId: $chainId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WCSessionRequest &&
        other.peerId == peerId &&
        other.peerMeta == peerMeta &&
        other.chainId == chainId;
  }

  @override
  int get hashCode => peerId.hashCode ^ peerMeta.hashCode ^ chainId.hashCode;
}
