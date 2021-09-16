// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wc_socket_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WCSocketMessage _$WCSocketMessageFromJson(Map<String, dynamic> json) {
  return WCSocketMessage(
    topic: json['topic'] as String,
    type: _$enumDecode(_$MessageTypeEnumMap, json['type']),
    payload: json['payload'] as String,
  );
}

Map<String, dynamic> _$WCSocketMessageToJson(WCSocketMessage instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'type': _$MessageTypeEnumMap[instance.type],
      'payload': instance.payload,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$MessageTypeEnumMap = {
  MessageType.PUB: 'pub',
  MessageType.SUB: 'sub',
};
