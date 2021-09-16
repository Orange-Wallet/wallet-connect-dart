import 'package:json_annotation/json_annotation.dart';

part 'wc_encryption_payload.g.dart';

@JsonSerializable()
class WCEncryptionPayload {
  final String data;
  final String hmac;
  final String iv;
  WCEncryptionPayload({
    required this.data,
    required this.hmac,
    required this.iv,
  });

  factory WCEncryptionPayload.fromJson(Map<String, dynamic> json) =>
      _$WCEncryptionPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$WCEncryptionPayloadToJson(this);

  @override
  String toString() => 'WCEncryptionPayload(data: $data, hmac: $hmac, iv: $iv)';
}
