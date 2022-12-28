// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseNamespace _$BaseNamespaceFromJson(Map<String, dynamic> json) =>
    BaseNamespace(
      (json['accounts'] as List<dynamic>).map((e) => e as String).toList(),
      (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      (json['events'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BaseNamespaceToJson(BaseNamespace instance) =>
    <String, dynamic>{
      'accounts': instance.accounts,
      'methods': instance.methods,
      'events': instance.events,
    };

Namespace _$NamespaceFromJson(Map<String, dynamic> json) => Namespace(
      (json['accounts'] as List<dynamic>).map((e) => e as String).toList(),
      (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      (json['events'] as List<dynamic>).map((e) => e as String).toList(),
      (json['extension'] as List<dynamic>)
          .map((e) => BaseNamespace.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NamespaceToJson(Namespace instance) => <String, dynamic>{
      'accounts': instance.accounts,
      'methods': instance.methods,
      'events': instance.events,
      'extension': instance.extension,
    };

SessionData _$SessionDataFromJson(Map<String, dynamic> json) => SessionData(
      json['topic'] as String,
      Relay.fromJson(json['relay'] as Map<String, dynamic>),
      json['expiry'] as int,
      json['acknowledged'] as bool,
      json['controller'] as String,
      (json['namespaces'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
      ConnectionMetadata.fromJson(json['self'] as Map<String, dynamic>),
      ConnectionMetadata.fromJson(json['peer'] as Map<String, dynamic>),
      requiredNamespaces:
          (json['requiredNamespaces'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$SessionDataToJson(SessionData instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'relay': instance.relay,
      'expiry': instance.expiry,
      'acknowledged': instance.acknowledged,
      'controller': instance.controller,
      'namespaces': instance.namespaces,
      'requiredNamespaces': instance.requiredNamespaces,
      'self': instance.self,
      'peer': instance.peer,
    };
