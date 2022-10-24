// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WCSession _$WCSessionFromJson(Map<String, dynamic> json) => WCSession(
      topic: json['topic'] as String,
      version: json['version'] as String,
      bridge: json['bridge'] as String,
      key: json['key'] as String,
    );

Map<String, dynamic> _$WCSessionToJson(WCSession instance) => <String, dynamic>{
      'topic': instance.topic,
      'version': instance.version,
      'bridge': instance.bridge,
      'key': instance.key,
    };
