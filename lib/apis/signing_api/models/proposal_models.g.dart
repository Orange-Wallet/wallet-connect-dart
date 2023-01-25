// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequiredNamespace _$BaseRequiredNamespaceFromJson(
        Map<String, dynamic> json) =>
    BaseRequiredNamespace(
      chains:
          (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
      methods:
          (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      events:
          (json['events'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BaseRequiredNamespaceToJson(
        BaseRequiredNamespace instance) =>
    <String, dynamic>{
      'chains': instance.chains,
      'methods': instance.methods,
      'events': instance.events,
    };

RequiredNamespace _$RequiredNamespaceFromJson(Map<String, dynamic> json) =>
    RequiredNamespace(
      chains:
          (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
      methods:
          (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      extension: (json['extension'] as List<dynamic>?)
          ?.map(
              (e) => BaseRequiredNamespace.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequiredNamespaceToJson(RequiredNamespace instance) {
  final val = <String, dynamic>{
    'chains': instance.chains,
    'methods': instance.methods,
    'events': instance.events,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('extension', instance.extension);
  return val;
}

ProposalData _$ProposalDataFromJson(Map<String, dynamic> json) => ProposalData(
      id: json['id'] as int,
      expiry: json['expiry'] as int,
      relays: (json['relays'] as List<dynamic>)
          .map((e) => Relay.fromJson(e as Map<String, dynamic>))
          .toList(),
      proposer:
          ConnectionMetadata.fromJson(json['proposer'] as Map<String, dynamic>),
      requiredNamespaces:
          (json['requiredNamespaces'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
      pairingTopic: json['pairingTopic'] as String?,
    );

Map<String, dynamic> _$ProposalDataToJson(ProposalData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expiry': instance.expiry,
      'relays': instance.relays,
      'proposer': instance.proposer,
      'requiredNamespaces': instance.requiredNamespaces,
      'pairingTopic': instance.pairingTopic,
    };
