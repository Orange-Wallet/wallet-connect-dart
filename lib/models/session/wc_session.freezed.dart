// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wc_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WCSession _$WCSessionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'default':
      return SessionData.fromJson(json);
    case 'empty':
      return EmptyWCSession.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'WCSession',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
class _$WCSessionTearOff {
  const _$WCSessionTearOff();

  SessionData call(
      {required String topic,
      required String version,
      required String bridge,
      required String key}) {
    return SessionData(
      topic: topic,
      version: version,
      bridge: bridge,
      key: key,
    );
  }

  EmptyWCSession empty(
      {String topic = '',
      String version = '',
      String bridge = '',
      String key = ''}) {
    return EmptyWCSession(
      topic: topic,
      version: version,
      bridge: bridge,
      key: key,
    );
  }

  WCSession fromJson(Map<String, Object?> json) {
    return WCSession.fromJson(json);
  }
}

/// @nodoc
const $WCSession = _$WCSessionTearOff();

/// @nodoc
mixin _$WCSession {
  String get topic => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get bridge => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String topic, String version, String bridge, String key)
        $default, {
    required TResult Function(
            String topic, String version, String bridge, String key)
        empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String topic, String version, String bridge, String key)?
        $default, {
    TResult Function(String topic, String version, String bridge, String key)?
        empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String topic, String version, String bridge, String key)?
        $default, {
    TResult Function(String topic, String version, String bridge, String key)?
        empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(SessionData value) $default, {
    required TResult Function(EmptyWCSession value) empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(SessionData value)? $default, {
    TResult Function(EmptyWCSession value)? empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(SessionData value)? $default, {
    TResult Function(EmptyWCSession value)? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WCSessionCopyWith<WCSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WCSessionCopyWith<$Res> {
  factory $WCSessionCopyWith(WCSession value, $Res Function(WCSession) then) =
      _$WCSessionCopyWithImpl<$Res>;
  $Res call({String topic, String version, String bridge, String key});
}

/// @nodoc
class _$WCSessionCopyWithImpl<$Res> implements $WCSessionCopyWith<$Res> {
  _$WCSessionCopyWithImpl(this._value, this._then);

  final WCSession _value;
  // ignore: unused_field
  final $Res Function(WCSession) _then;

  @override
  $Res call({
    Object? topic = freezed,
    Object? version = freezed,
    Object? bridge = freezed,
    Object? key = freezed,
  }) {
    return _then(_value.copyWith(
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      bridge: bridge == freezed
          ? _value.bridge
          : bridge // ignore: cast_nullable_to_non_nullable
              as String,
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $SessionDataCopyWith<$Res> implements $WCSessionCopyWith<$Res> {
  factory $SessionDataCopyWith(
          SessionData value, $Res Function(SessionData) then) =
      _$SessionDataCopyWithImpl<$Res>;
  @override
  $Res call({String topic, String version, String bridge, String key});
}

/// @nodoc
class _$SessionDataCopyWithImpl<$Res> extends _$WCSessionCopyWithImpl<$Res>
    implements $SessionDataCopyWith<$Res> {
  _$SessionDataCopyWithImpl(
      SessionData _value, $Res Function(SessionData) _then)
      : super(_value, (v) => _then(v as SessionData));

  @override
  SessionData get _value => super._value as SessionData;

  @override
  $Res call({
    Object? topic = freezed,
    Object? version = freezed,
    Object? bridge = freezed,
    Object? key = freezed,
  }) {
    return _then(SessionData(
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      bridge: bridge == freezed
          ? _value.bridge
          : bridge // ignore: cast_nullable_to_non_nullable
              as String,
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionData extends SessionData {
  const _$SessionData(
      {required this.topic,
      required this.version,
      required this.bridge,
      required this.key,
      String? $type})
      : $type = $type ?? 'default',
        super._();

  factory _$SessionData.fromJson(Map<String, dynamic> json) =>
      _$$SessionDataFromJson(json);

  @override
  final String topic;
  @override
  final String version;
  @override
  final String bridge;
  @override
  final String key;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WCSession(topic: $topic, version: $version, bridge: $bridge, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SessionData &&
            const DeepCollectionEquality().equals(other.topic, topic) &&
            const DeepCollectionEquality().equals(other.version, version) &&
            const DeepCollectionEquality().equals(other.bridge, bridge) &&
            const DeepCollectionEquality().equals(other.key, key));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(topic),
      const DeepCollectionEquality().hash(version),
      const DeepCollectionEquality().hash(bridge),
      const DeepCollectionEquality().hash(key));

  @JsonKey(ignore: true)
  @override
  $SessionDataCopyWith<SessionData> get copyWith =>
      _$SessionDataCopyWithImpl<SessionData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String topic, String version, String bridge, String key)
        $default, {
    required TResult Function(
            String topic, String version, String bridge, String key)
        empty,
  }) {
    return $default(topic, version, bridge, key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String topic, String version, String bridge, String key)?
        $default, {
    TResult Function(String topic, String version, String bridge, String key)?
        empty,
  }) {
    return $default?.call(topic, version, bridge, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String topic, String version, String bridge, String key)?
        $default, {
    TResult Function(String topic, String version, String bridge, String key)?
        empty,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(topic, version, bridge, key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(SessionData value) $default, {
    required TResult Function(EmptyWCSession value) empty,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(SessionData value)? $default, {
    TResult Function(EmptyWCSession value)? empty,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(SessionData value)? $default, {
    TResult Function(EmptyWCSession value)? empty,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionDataToJson(this);
  }
}

abstract class SessionData extends WCSession {
  const factory SessionData(
      {required String topic,
      required String version,
      required String bridge,
      required String key}) = _$SessionData;
  const SessionData._() : super._();

  factory SessionData.fromJson(Map<String, dynamic> json) =
      _$SessionData.fromJson;

  @override
  String get topic;
  @override
  String get version;
  @override
  String get bridge;
  @override
  String get key;
  @override
  @JsonKey(ignore: true)
  $SessionDataCopyWith<SessionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmptyWCSessionCopyWith<$Res>
    implements $WCSessionCopyWith<$Res> {
  factory $EmptyWCSessionCopyWith(
          EmptyWCSession value, $Res Function(EmptyWCSession) then) =
      _$EmptyWCSessionCopyWithImpl<$Res>;
  @override
  $Res call({String topic, String version, String bridge, String key});
}

/// @nodoc
class _$EmptyWCSessionCopyWithImpl<$Res> extends _$WCSessionCopyWithImpl<$Res>
    implements $EmptyWCSessionCopyWith<$Res> {
  _$EmptyWCSessionCopyWithImpl(
      EmptyWCSession _value, $Res Function(EmptyWCSession) _then)
      : super(_value, (v) => _then(v as EmptyWCSession));

  @override
  EmptyWCSession get _value => super._value as EmptyWCSession;

  @override
  $Res call({
    Object? topic = freezed,
    Object? version = freezed,
    Object? bridge = freezed,
    Object? key = freezed,
  }) {
    return _then(EmptyWCSession(
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      bridge: bridge == freezed
          ? _value.bridge
          : bridge // ignore: cast_nullable_to_non_nullable
              as String,
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmptyWCSession extends EmptyWCSession {
  const _$EmptyWCSession(
      {this.topic = '',
      this.version = '',
      this.bridge = '',
      this.key = '',
      String? $type})
      : $type = $type ?? 'empty',
        super._();

  factory _$EmptyWCSession.fromJson(Map<String, dynamic> json) =>
      _$$EmptyWCSessionFromJson(json);

  @JsonKey()
  @override
  final String topic;
  @JsonKey()
  @override
  final String version;
  @JsonKey()
  @override
  final String bridge;
  @JsonKey()
  @override
  final String key;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'WCSession.empty(topic: $topic, version: $version, bridge: $bridge, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmptyWCSession &&
            const DeepCollectionEquality().equals(other.topic, topic) &&
            const DeepCollectionEquality().equals(other.version, version) &&
            const DeepCollectionEquality().equals(other.bridge, bridge) &&
            const DeepCollectionEquality().equals(other.key, key));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(topic),
      const DeepCollectionEquality().hash(version),
      const DeepCollectionEquality().hash(bridge),
      const DeepCollectionEquality().hash(key));

  @JsonKey(ignore: true)
  @override
  $EmptyWCSessionCopyWith<EmptyWCSession> get copyWith =>
      _$EmptyWCSessionCopyWithImpl<EmptyWCSession>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String topic, String version, String bridge, String key)
        $default, {
    required TResult Function(
            String topic, String version, String bridge, String key)
        empty,
  }) {
    return empty(topic, version, bridge, key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(String topic, String version, String bridge, String key)?
        $default, {
    TResult Function(String topic, String version, String bridge, String key)?
        empty,
  }) {
    return empty?.call(topic, version, bridge, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String topic, String version, String bridge, String key)?
        $default, {
    TResult Function(String topic, String version, String bridge, String key)?
        empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(topic, version, bridge, key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(SessionData value) $default, {
    required TResult Function(EmptyWCSession value) empty,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(SessionData value)? $default, {
    TResult Function(EmptyWCSession value)? empty,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(SessionData value)? $default, {
    TResult Function(EmptyWCSession value)? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EmptyWCSessionToJson(this);
  }
}

abstract class EmptyWCSession extends WCSession {
  const factory EmptyWCSession(
      {String topic,
      String version,
      String bridge,
      String key}) = _$EmptyWCSession;
  const EmptyWCSession._() : super._();

  factory EmptyWCSession.fromJson(Map<String, dynamic> json) =
      _$EmptyWCSession.fromJson;

  @override
  String get topic;
  @override
  String get version;
  @override
  String get bridge;
  @override
  String get key;
  @override
  @JsonKey(ignore: true)
  $EmptyWCSessionCopyWith<EmptyWCSession> get copyWith =>
      throw _privateConstructorUsedError;
}
