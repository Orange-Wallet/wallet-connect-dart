// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'json_rpc_error_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JsonRpcErrorResponse _$JsonRpcErrorResponseFromJson(Map<String, dynamic> json) {
  return _JsonRpcErrorResponse.fromJson(json);
}

/// @nodoc
class _$JsonRpcErrorResponseTearOff {
  const _$JsonRpcErrorResponseTearOff();

  _JsonRpcErrorResponse call(
      {required int id,
      required JsonRpcError error,
      String jsonrpc = JSONRPC_VERSION}) {
    return _JsonRpcErrorResponse(
      id: id,
      error: error,
      jsonrpc: jsonrpc,
    );
  }

  JsonRpcErrorResponse fromJson(Map<String, Object?> json) {
    return JsonRpcErrorResponse.fromJson(json);
  }
}

/// @nodoc
const $JsonRpcErrorResponse = _$JsonRpcErrorResponseTearOff();

/// @nodoc
mixin _$JsonRpcErrorResponse {
  int get id => throw _privateConstructorUsedError;
  JsonRpcError get error => throw _privateConstructorUsedError;
  String get jsonrpc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonRpcErrorResponseCopyWith<JsonRpcErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonRpcErrorResponseCopyWith<$Res> {
  factory $JsonRpcErrorResponseCopyWith(JsonRpcErrorResponse value,
          $Res Function(JsonRpcErrorResponse) then) =
      _$JsonRpcErrorResponseCopyWithImpl<$Res>;
  $Res call({int id, JsonRpcError error, String jsonrpc});

  $JsonRpcErrorCopyWith<$Res> get error;
}

/// @nodoc
class _$JsonRpcErrorResponseCopyWithImpl<$Res>
    implements $JsonRpcErrorResponseCopyWith<$Res> {
  _$JsonRpcErrorResponseCopyWithImpl(this._value, this._then);

  final JsonRpcErrorResponse _value;
  // ignore: unused_field
  final $Res Function(JsonRpcErrorResponse) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? error = freezed,
    Object? jsonrpc = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as JsonRpcError,
      jsonrpc: jsonrpc == freezed
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $JsonRpcErrorCopyWith<$Res> get error {
    return $JsonRpcErrorCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc
abstract class _$JsonRpcErrorResponseCopyWith<$Res>
    implements $JsonRpcErrorResponseCopyWith<$Res> {
  factory _$JsonRpcErrorResponseCopyWith(_JsonRpcErrorResponse value,
          $Res Function(_JsonRpcErrorResponse) then) =
      __$JsonRpcErrorResponseCopyWithImpl<$Res>;
  @override
  $Res call({int id, JsonRpcError error, String jsonrpc});

  @override
  $JsonRpcErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$JsonRpcErrorResponseCopyWithImpl<$Res>
    extends _$JsonRpcErrorResponseCopyWithImpl<$Res>
    implements _$JsonRpcErrorResponseCopyWith<$Res> {
  __$JsonRpcErrorResponseCopyWithImpl(
      _JsonRpcErrorResponse _value, $Res Function(_JsonRpcErrorResponse) _then)
      : super(_value, (v) => _then(v as _JsonRpcErrorResponse));

  @override
  _JsonRpcErrorResponse get _value => super._value as _JsonRpcErrorResponse;

  @override
  $Res call({
    Object? id = freezed,
    Object? error = freezed,
    Object? jsonrpc = freezed,
  }) {
    return _then(_JsonRpcErrorResponse(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as JsonRpcError,
      jsonrpc: jsonrpc == freezed
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JsonRpcErrorResponse implements _JsonRpcErrorResponse {
  _$_JsonRpcErrorResponse(
      {required this.id, required this.error, this.jsonrpc = JSONRPC_VERSION});

  factory _$_JsonRpcErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$$_JsonRpcErrorResponseFromJson(json);

  @override
  final int id;
  @override
  final JsonRpcError error;
  @JsonKey()
  @override
  final String jsonrpc;

  @override
  String toString() {
    return 'JsonRpcErrorResponse(id: $id, error: $error, jsonrpc: $jsonrpc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JsonRpcErrorResponse &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other.jsonrpc, jsonrpc));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(jsonrpc));

  @JsonKey(ignore: true)
  @override
  _$JsonRpcErrorResponseCopyWith<_JsonRpcErrorResponse> get copyWith =>
      __$JsonRpcErrorResponseCopyWithImpl<_JsonRpcErrorResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JsonRpcErrorResponseToJson(this);
  }
}

abstract class _JsonRpcErrorResponse implements JsonRpcErrorResponse {
  factory _JsonRpcErrorResponse(
      {required int id,
      required JsonRpcError error,
      String jsonrpc}) = _$_JsonRpcErrorResponse;

  factory _JsonRpcErrorResponse.fromJson(Map<String, dynamic> json) =
      _$_JsonRpcErrorResponse.fromJson;

  @override
  int get id;
  @override
  JsonRpcError get error;
  @override
  String get jsonrpc;
  @override
  @JsonKey(ignore: true)
  _$JsonRpcErrorResponseCopyWith<_JsonRpcErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
