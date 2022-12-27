import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_v2/apis/signing_api/models/generic_models.dart';

part 'proposal_models.g.dart';

@JsonSerializable()
class BaseRequiredNamespace {
  final List<String> chains;
  final List<String> methods;
  final List<String> events;

  BaseRequiredNamespace(
    this.chains,
    this.methods,
    this.events,
  );

  factory BaseRequiredNamespace.fromJson(Map<String, dynamic> json) =>
      _$BaseRequiredNamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$BaseRequiredNamespaceToJson(this);
}

@JsonSerializable()
class RequiredNamespace extends BaseRequiredNamespace {
  final List<BaseRequiredNamespace> extension;

  RequiredNamespace(
    this.extension,
    List<String> chains,
    List<String> methods,
    List<String> events,
  ) : super(
          chains,
          methods,
          events,
        );

  factory RequiredNamespace.fromJson(Map<String, dynamic> json) =>
      _$RequiredNamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$RequiredNamespaceToJson(this);
}

@JsonSerializable()
class ProposalData {
  final int id;
  final int expiry;
  final List<Relay> relays;
  final ConnectionMetadata proposer;
  final Map<String, RequiredNamespace> requiredNamespaces;
  final String? pairingTopic;

  ProposalData(
    this.id,
    this.expiry,
    this.relays,
    this.proposer,
    this.requiredNamespaces,
    this.pairingTopic,
  );

  factory ProposalData.fromJson(Map<String, dynamic> json) =>
      _$ProposalDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProposalDataToJson(this);
}
