import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet_connect/wallet_connect.dart';

part 'wc_session_request.freezed.dart';
part 'wc_session_request.g.dart';

@immutable
@freezed
class WCSessionRequest with _$WCSessionRequest {
  factory WCSessionRequest({
    required String peerId,
    required WCPeerMeta peerMeta,
    int? chainId,
  }) = _WCSessionRequest;

  factory WCSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$WCSessionRequestFromJson(json);
}
