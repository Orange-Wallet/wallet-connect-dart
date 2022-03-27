import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_connect/models/wc_peer_meta.dart';

part 'wc_approve_session_response.freezed.dart';
part 'wc_approve_session_response.g.dart';

@immutable
@freezed
class WCApproveSessionResponse with _$WCApproveSessionResponse {
  factory WCApproveSessionResponse({
    @Default(true) bool approved,
    int? chainId,
    required List<String> accounts,
    required String peerId,
    required WCPeerMeta peerMeta,
  }) = _WCApproveSessionResponse;

  factory WCApproveSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$WCApproveSessionResponseFromJson(json);
}
