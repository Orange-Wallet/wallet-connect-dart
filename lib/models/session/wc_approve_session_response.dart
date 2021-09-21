import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:wallet_connect/models/wc_peer_meta.dart';

part 'wc_approve_session_response.g.dart';

@JsonSerializable()
class WCApproveSessionResponse {
  final bool approved;
  final int chainId;
  final List<String> accounts;
  final String peerId;
  final WCPeerMeta peerMeta;
  WCApproveSessionResponse({
    this.approved = true,
    this.chainId,
    @required this.accounts,
    @required this.peerId,
    @required this.peerMeta,
  });

  factory WCApproveSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$WCApproveSessionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WCApproveSessionResponseToJson(this);

  @override
  String toString() {
    return 'WCApproveSessionResponse(approved: $approved, chainId: $chainId, account: $accounts, peerId: $peerId, peerMeta: $peerMeta)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WCApproveSessionResponse &&
        other.approved == approved &&
        other.chainId == chainId &&
        listEquals(other.accounts, accounts) &&
        other.peerId == peerId &&
        other.peerMeta == peerMeta;
  }

  @override
  int get hashCode {
    return approved.hashCode ^
        chainId.hashCode ^
        accounts.hashCode ^
        peerId.hashCode ^
        peerMeta.hashCode;
  }
}
