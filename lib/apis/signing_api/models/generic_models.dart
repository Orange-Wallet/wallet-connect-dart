import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_v2/apis/core/pairing/pairing_models.dart';

part 'generic_models.g.dart';

@JsonSerializable()
class ConnectionMetadata {
  String publicKey;
  PairingMetadata metadata;

  ConnectionMetadata(
    this.publicKey,
    this.metadata,
  );

  factory ConnectionMetadata.fromJson(Map<String, dynamic> json) =>
      _$ConnectionMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionMetadataToJson(this);

  @override
  bool operator ==(Object other) {
    return other is ConnectionMetadata && hashCode == other.hashCode;
  }

  @override
  int get hashCode => publicKey.hashCode + metadata.hashCode;
}
