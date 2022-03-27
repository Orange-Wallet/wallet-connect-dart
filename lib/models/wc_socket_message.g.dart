// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_socket_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WCSocketMessage _$$_WCSocketMessageFromJson(Map<String, dynamic> json) =>
    _$_WCSocketMessage(
      topic: json['topic'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      payload: json['payload'] as String,
    );

Map<String, dynamic> _$$_WCSocketMessageToJson(_$_WCSocketMessage instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'type': _$MessageTypeEnumMap[instance.type],
      'payload': instance.payload,
    };

const _$MessageTypeEnumMap = {
  MessageType.PUB: 'pub',
  MessageType.SUB: 'sub',
};
