// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequiredNamespace _$BaseRequiredNamespaceFromJson(
        Map<String, dynamic> json) =>
    BaseRequiredNamespace(
      (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
      (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
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
      (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
      (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      (json['events'] as List<dynamic>).map((e) => e as String).toList(),
      (json['extension'] as List<dynamic>)
          .map((e) => BaseRequiredNamespace.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequiredNamespaceToJson(RequiredNamespace instance) =>
    <String, dynamic>{
      'chains': instance.chains,
      'methods': instance.methods,
      'events': instance.events,
      'extension': instance.extension,
    };

ProposalData _$ProposalDataFromJson(Map<String, dynamic> json) => ProposalData(
      json['id'] as int,
      json['expiry'] as int,
      (json['relays'] as List<dynamic>)
          .map((e) => Relay.fromJson(e as Map<String, dynamic>))
          .toList(),
      ConnectionMetadata.fromJson(json['proposer'] as Map<String, dynamic>),
      (json['requiredNamespaces'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
      json['pairingTopic'] as String?,
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
