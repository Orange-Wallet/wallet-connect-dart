import 'package:json_annotation/json_annotation.dart';

part 'relay_client_models.g.dart';

@JsonSerializable()
class Relay {
  final String protocol;
  final String? data;

  Relay(
    this.protocol,
    this.data,
  );

  factory Relay.fromJson(Map<String, dynamic> json) => _$RelayFromJson(json);

  Map<String, dynamic> toJson() => _$RelayToJson(this);
}
