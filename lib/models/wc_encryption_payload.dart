import 'package:freezed_annotation/freezed_annotation.dart';

part 'wc_encryption_payload.freezed.dart';
part 'wc_encryption_payload.g.dart';

@immutable
@freezed
class WCEncryptionPayload with _$WCEncryptionPayload {
  factory WCEncryptionPayload({
    required String data,
    required String hmac,
    required String iv,
  }) = _WCEncryptionPayload;

  factory WCEncryptionPayload.fromJson(Map<String, dynamic> json) =>
      _$WCEncryptionPayloadFromJson(json);
}
