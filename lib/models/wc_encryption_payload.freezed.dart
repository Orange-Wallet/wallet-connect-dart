// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wc_encryption_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WCEncryptionPayload _$WCEncryptionPayloadFromJson(Map<String, dynamic> json) {
  return _WCEncryptionPayload.fromJson(json);
}

/// @nodoc
class _$WCEncryptionPayloadTearOff {
  const _$WCEncryptionPayloadTearOff();

  _WCEncryptionPayload call(
      {required String data, required String hmac, required String iv}) {
    return _WCEncryptionPayload(
      data: data,
      hmac: hmac,
      iv: iv,
    );
  }

  WCEncryptionPayload fromJson(Map<String, Object?> json) {
    return WCEncryptionPayload.fromJson(json);
  }
}

/// @nodoc
const $WCEncryptionPayload = _$WCEncryptionPayloadTearOff();

/// @nodoc
mixin _$WCEncryptionPayload {
  String get data => throw _privateConstructorUsedError;
  String get hmac => throw _privateConstructorUsedError;
  String get iv => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WCEncryptionPayloadCopyWith<WCEncryptionPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WCEncryptionPayloadCopyWith<$Res> {
  factory $WCEncryptionPayloadCopyWith(
          WCEncryptionPayload value, $Res Function(WCEncryptionPayload) then) =
      _$WCEncryptionPayloadCopyWithImpl<$Res>;
  $Res call({String data, String hmac, String iv});
}

/// @nodoc
class _$WCEncryptionPayloadCopyWithImpl<$Res>
    implements $WCEncryptionPayloadCopyWith<$Res> {
  _$WCEncryptionPayloadCopyWithImpl(this._value, this._then);

  final WCEncryptionPayload _value;
  // ignore: unused_field
  final $Res Function(WCEncryptionPayload) _then;

  @override
  $Res call({
    Object? data = freezed,
    Object? hmac = freezed,
    Object? iv = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      hmac: hmac == freezed
          ? _value.hmac
          : hmac // ignore: cast_nullable_to_non_nullable
              as String,
      iv: iv == freezed
          ? _value.iv
          : iv // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$WCEncryptionPayloadCopyWith<$Res>
    implements $WCEncryptionPayloadCopyWith<$Res> {
  factory _$WCEncryptionPayloadCopyWith(_WCEncryptionPayload value,
          $Res Function(_WCEncryptionPayload) then) =
      __$WCEncryptionPayloadCopyWithImpl<$Res>;
  @override
  $Res call({String data, String hmac, String iv});
}

/// @nodoc
class __$WCEncryptionPayloadCopyWithImpl<$Res>
    extends _$WCEncryptionPayloadCopyWithImpl<$Res>
    implements _$WCEncryptionPayloadCopyWith<$Res> {
  __$WCEncryptionPayloadCopyWithImpl(
      _WCEncryptionPayload _value, $Res Function(_WCEncryptionPayload) _then)
      : super(_value, (v) => _then(v as _WCEncryptionPayload));

  @override
  _WCEncryptionPayload get _value => super._value as _WCEncryptionPayload;

  @override
  $Res call({
    Object? data = freezed,
    Object? hmac = freezed,
    Object? iv = freezed,
  }) {
    return _then(_WCEncryptionPayload(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      hmac: hmac == freezed
          ? _value.hmac
          : hmac // ignore: cast_nullable_to_non_nullable
              as String,
      iv: iv == freezed
          ? _value.iv
          : iv // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WCEncryptionPayload implements _WCEncryptionPayload {
  _$_WCEncryptionPayload(
      {required this.data, required this.hmac, required this.iv});

  factory _$_WCEncryptionPayload.fromJson(Map<String, dynamic> json) =>
      _$$_WCEncryptionPayloadFromJson(json);

  @override
  final String data;
  @override
  final String hmac;
  @override
  final String iv;

  @override
  String toString() {
    return 'WCEncryptionPayload(data: $data, hmac: $hmac, iv: $iv)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WCEncryptionPayload &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.hmac, hmac) &&
            const DeepCollectionEquality().equals(other.iv, iv));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(hmac),
      const DeepCollectionEquality().hash(iv));

  @JsonKey(ignore: true)
  @override
  _$WCEncryptionPayloadCopyWith<_WCEncryptionPayload> get copyWith =>
      __$WCEncryptionPayloadCopyWithImpl<_WCEncryptionPayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WCEncryptionPayloadToJson(this);
  }
}

abstract class _WCEncryptionPayload implements WCEncryptionPayload {
  factory _WCEncryptionPayload(
      {required String data,
      required String hmac,
      required String iv}) = _$_WCEncryptionPayload;

  factory _WCEncryptionPayload.fromJson(Map<String, dynamic> json) =
      _$_WCEncryptionPayload.fromJson;

  @override
  String get data;
  @override
  String get hmac;
  @override
  String get iv;
  @override
  @JsonKey(ignore: true)
  _$WCEncryptionPayloadCopyWith<_WCEncryptionPayload> get copyWith =>
      throw _privateConstructorUsedError;
}
