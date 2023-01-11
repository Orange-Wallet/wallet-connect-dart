// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseNamespace _$BaseNamespaceFromJson(Map<String, dynamic> json) =>
    BaseNamespace(
      accounts:
          (json['accounts'] as List<dynamic>).map((e) => e as String).toList(),
      methods:
          (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      events:
          (json['events'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BaseNamespaceToJson(BaseNamespace instance) =>
    <String, dynamic>{
      'accounts': instance.accounts,
      'methods': instance.methods,
      'events': instance.events,
    };

Namespace _$NamespaceFromJson(Map<String, dynamic> json) => Namespace(
      accounts:
          (json['accounts'] as List<dynamic>).map((e) => e as String).toList(),
      methods:
          (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      events:
          (json['events'] as List<dynamic>).map((e) => e as String).toList(),
      extension: (json['extension'] as List<dynamic>)
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
      topic: json['topic'] as String,
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      expiry: json['expiry'] as int,
      acknowledged: json['acknowledged'] as bool,
      controller: json['controller'] as String,
      namespaces: (json['namespaces'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
      self: ConnectionMetadata.fromJson(json['self'] as Map<String, dynamic>),
      peer: ConnectionMetadata.fromJson(json['peer'] as Map<String, dynamic>),
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
