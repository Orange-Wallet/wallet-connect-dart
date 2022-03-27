// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wc_socket_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WCSocketMessage _$WCSocketMessageFromJson(Map<String, dynamic> json) {
  return _WCSocketMessage.fromJson(json);
}

/// @nodoc
class _$WCSocketMessageTearOff {
  const _$WCSocketMessageTearOff();

  _WCSocketMessage call(
      {required String topic,
      required MessageType type,
      required String payload}) {
    return _WCSocketMessage(
      topic: topic,
      type: type,
      payload: payload,
    );
  }

  WCSocketMessage fromJson(Map<String, Object?> json) {
    return WCSocketMessage.fromJson(json);
  }
}

/// @nodoc
const $WCSocketMessage = _$WCSocketMessageTearOff();

/// @nodoc
mixin _$WCSocketMessage {
  String get topic => throw _privateConstructorUsedError;
  MessageType get type => throw _privateConstructorUsedError;
  String get payload => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WCSocketMessageCopyWith<WCSocketMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WCSocketMessageCopyWith<$Res> {
  factory $WCSocketMessageCopyWith(
          WCSocketMessage value, $Res Function(WCSocketMessage) then) =
      _$WCSocketMessageCopyWithImpl<$Res>;
  $Res call({String topic, MessageType type, String payload});
}

/// @nodoc
class _$WCSocketMessageCopyWithImpl<$Res>
    implements $WCSocketMessageCopyWith<$Res> {
  _$WCSocketMessageCopyWithImpl(this._value, this._then);

  final WCSocketMessage _value;
  // ignore: unused_field
  final $Res Function(WCSocketMessage) _then;

  @override
  $Res call({
    Object? topic = freezed,
    Object? type = freezed,
    Object? payload = freezed,
  }) {
    return _then(_value.copyWith(
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      payload: payload == freezed
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$WCSocketMessageCopyWith<$Res>
    implements $WCSocketMessageCopyWith<$Res> {
  factory _$WCSocketMessageCopyWith(
          _WCSocketMessage value, $Res Function(_WCSocketMessage) then) =
      __$WCSocketMessageCopyWithImpl<$Res>;
  @override
  $Res call({String topic, MessageType type, String payload});
}

/// @nodoc
class __$WCSocketMessageCopyWithImpl<$Res>
    extends _$WCSocketMessageCopyWithImpl<$Res>
    implements _$WCSocketMessageCopyWith<$Res> {
  __$WCSocketMessageCopyWithImpl(
      _WCSocketMessage _value, $Res Function(_WCSocketMessage) _then)
      : super(_value, (v) => _then(v as _WCSocketMessage));

  @override
  _WCSocketMessage get _value => super._value as _WCSocketMessage;

  @override
  $Res call({
    Object? topic = freezed,
    Object? type = freezed,
    Object? payload = freezed,
  }) {
    return _then(_WCSocketMessage(
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      payload: payload == freezed
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WCSocketMessage implements _WCSocketMessage {
  _$_WCSocketMessage(
      {required this.topic, required this.type, required this.payload});

  factory _$_WCSocketMessage.fromJson(Map<String, dynamic> json) =>
      _$$_WCSocketMessageFromJson(json);

  @override
  final String topic;
  @override
  final MessageType type;
  @override
  final String payload;

  @override
  String toString() {
    return 'WCSocketMessage(topic: $topic, type: $type, payload: $payload)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WCSocketMessage &&
            const DeepCollectionEquality().equals(other.topic, topic) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.payload, payload));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(topic),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(payload));

  @JsonKey(ignore: true)
  @override
  _$WCSocketMessageCopyWith<_WCSocketMessage> get copyWith =>
      __$WCSocketMessageCopyWithImpl<_WCSocketMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WCSocketMessageToJson(this);
  }
}

abstract class _WCSocketMessage implements WCSocketMessage {
  factory _WCSocketMessage(
      {required String topic,
      required MessageType type,
      required String payload}) = _$_WCSocketMessage;

  factory _WCSocketMessage.fromJson(Map<String, dynamic> json) =
      _$_WCSocketMessage.fromJson;

  @override
  String get topic;
  @override
  MessageType get type;
  @override
  String get payload;
  @override
  @JsonKey(ignore: true)
  _$WCSocketMessageCopyWith<_WCSocketMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
