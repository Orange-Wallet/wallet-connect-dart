// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionData _$$SessionDataFromJson(Map<String, dynamic> json) =>
    _$SessionData(
      topic: json['topic'] as String,
      version: json['version'] as String,
      bridge: json['bridge'] as String,
      key: json['key'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SessionDataToJson(_$SessionData instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'version': instance.version,
      'bridge': instance.bridge,
      'key': instance.key,
      'runtimeType': instance.$type,
    };

_$EmptyWCSession _$$EmptyWCSessionFromJson(Map<String, dynamic> json) =>
    _$EmptyWCSession(
      topic: json['topic'] as String? ?? '',
      version: json['version'] as String? ?? '',
      bridge: json['bridge'] as String? ?? '',
      key: json['key'] as String? ?? '',
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$EmptyWCSessionToJson(_$EmptyWCSession instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'version': instance.version,
      'bridge': instance.bridge,
      'key': instance.key,
      'runtimeType': instance.$type,
    };
