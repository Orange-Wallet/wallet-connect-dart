import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_v2/apis/core/relay_auth/relay_auth_models.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';

part 'pairing_models.g.dart';

@JsonSerializable()
class PairingInfo {
  String topic;
  // Value in seconds
  int expiry;
  Relay relay;
  bool active;
  PairingMetadata? peerMetadata;

  PairingInfo(
    this.topic,
    this.expiry,
    this.relay,
    this.active, {
    this.peerMetadata,
  });

  factory PairingInfo.fromJson(Map<String, dynamic> json) =>
      _$PairingInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PairingInfoToJson(this);
}

@JsonSerializable()
class PairingMetadata {
  final String name;
  final String description;
  final String url;
  final List<String> icons;
  final Redirect? redirect;

  PairingMetadata(
    this.name,
    this.description,
    this.url,
    this.icons,
    this.redirect,
  );

  factory PairingMetadata.fromJson(Map<String, dynamic> json) =>
      _$PairingMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$PairingMetadataToJson(this);
}

@JsonSerializable()
class Redirect {
  final String? native;
  final String? universal;

  Redirect(
    this.native,
    this.universal,
  );

  factory Redirect.fromJson(Map<String, dynamic> json) =>
      _$RedirectFromJson(json);

  Map<String, dynamic> toJson() => _$RedirectToJson(this);
}

class CreateResponse {
  String topic;
  String uri;

  CreateResponse(
    this.topic,
    this.uri,
  );
}
