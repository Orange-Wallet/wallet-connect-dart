// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_socket_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WCSocketMessage _$WCSocketMessageFromJson(Map<String, dynamic> json) =>
    WCSocketMessage(
      topic: json['topic'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      payload: json['payload'] as String,
    );

Map<String, dynamic> _$WCSocketMessageToJson(WCSocketMessage instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'payload': instance.payload,
    };

const _$MessageTypeEnumMap = {
  MessageType.PUB: 'pub',
  MessageType.SUB: 'sub',
};
