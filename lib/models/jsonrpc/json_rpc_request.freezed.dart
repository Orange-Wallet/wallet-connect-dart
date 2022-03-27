// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'json_rpc_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JsonRpcRequest _$JsonRpcRequestFromJson(Map<String, dynamic> json) {
  return _JsonRpcRequest.fromJson(json);
}

/// @nodoc
class _$JsonRpcRequestTearOff {
  const _$JsonRpcRequestTearOff();

  _JsonRpcRequest call(
      {required int id,
      String jsonrpc = JSONRPC_VERSION,
      WCMethod? method,
      required List<dynamic>? params}) {
    return _JsonRpcRequest(
      id: id,
      jsonrpc: jsonrpc,
      method: method,
      params: params,
    );
  }

  JsonRpcRequest fromJson(Map<String, Object?> json) {
    return JsonRpcRequest.fromJson(json);
  }
}

/// @nodoc
const $JsonRpcRequest = _$JsonRpcRequestTearOff();

/// @nodoc
mixin _$JsonRpcRequest {
  int get id => throw _privateConstructorUsedError;
  String get jsonrpc => throw _privateConstructorUsedError;
  WCMethod? get method => throw _privateConstructorUsedError;
  List<dynamic>? get params => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonRpcRequestCopyWith<JsonRpcRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonRpcRequestCopyWith<$Res> {
  factory $JsonRpcRequestCopyWith(
          JsonRpcRequest value, $Res Function(JsonRpcRequest) then) =
      _$JsonRpcRequestCopyWithImpl<$Res>;
  $Res call({int id, String jsonrpc, WCMethod? method, List<dynamic>? params});
}

/// @nodoc
class _$JsonRpcRequestCopyWithImpl<$Res>
    implements $JsonRpcRequestCopyWith<$Res> {
  _$JsonRpcRequestCopyWithImpl(this._value, this._then);

  final JsonRpcRequest _value;
  // ignore: unused_field
  final $Res Function(JsonRpcRequest) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? jsonrpc = freezed,
    Object? method = freezed,
    Object? params = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: jsonrpc == freezed
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      method: method == freezed
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as WCMethod?,
      params: params == freezed
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
abstract class _$JsonRpcRequestCopyWith<$Res>
    implements $JsonRpcRequestCopyWith<$Res> {
  factory _$JsonRpcRequestCopyWith(
          _JsonRpcRequest value, $Res Function(_JsonRpcRequest) then) =
      __$JsonRpcRequestCopyWithImpl<$Res>;
  @override
  $Res call({int id, String jsonrpc, WCMethod? method, List<dynamic>? params});
}

/// @nodoc
class __$JsonRpcRequestCopyWithImpl<$Res>
    extends _$JsonRpcRequestCopyWithImpl<$Res>
    implements _$JsonRpcRequestCopyWith<$Res> {
  __$JsonRpcRequestCopyWithImpl(
      _JsonRpcRequest _value, $Res Function(_JsonRpcRequest) _then)
      : super(_value, (v) => _then(v as _JsonRpcRequest));

  @override
  _JsonRpcRequest get _value => super._value as _JsonRpcRequest;

  @override
  $Res call({
    Object? id = freezed,
    Object? jsonrpc = freezed,
    Object? method = freezed,
    Object? params = freezed,
  }) {
    return _then(_JsonRpcRequest(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: jsonrpc == freezed
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      method: method == freezed
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as WCMethod?,
      params: params == freezed
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JsonRpcRequest implements _JsonRpcRequest {
  _$_JsonRpcRequest(
      {required this.id,
      this.jsonrpc = JSONRPC_VERSION,
      this.method,
      required this.params});

  factory _$_JsonRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$$_JsonRpcRequestFromJson(json);

  @override
  final int id;
  @JsonKey()
  @override
  final String jsonrpc;
  @override
  final WCMethod? method;
  @override
  final List<dynamic>? params;

  @override
  String toString() {
    return 'JsonRpcRequest(id: $id, jsonrpc: $jsonrpc, method: $method, params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JsonRpcRequest &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.jsonrpc, jsonrpc) &&
            const DeepCollectionEquality().equals(other.method, method) &&
            const DeepCollectionEquality().equals(other.params, params));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(jsonrpc),
      const DeepCollectionEquality().hash(method),
      const DeepCollectionEquality().hash(params));

  @JsonKey(ignore: true)
  @override
  _$JsonRpcRequestCopyWith<_JsonRpcRequest> get copyWith =>
      __$JsonRpcRequestCopyWithImpl<_JsonRpcRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JsonRpcRequestToJson(this);
  }
}

abstract class _JsonRpcRequest implements JsonRpcRequest {
  factory _JsonRpcRequest(
      {required int id,
      String jsonrpc,
      WCMethod? method,
      required List<dynamic>? params}) = _$_JsonRpcRequest;

  factory _JsonRpcRequest.fromJson(Map<String, dynamic> json) =
      _$_JsonRpcRequest.fromJson;

  @override
  int get id;
  @override
  String get jsonrpc;
  @override
  WCMethod? get method;
  @override
  List<dynamic>? get params;
  @override
  @JsonKey(ignore: true)
  _$JsonRpcRequestCopyWith<_JsonRpcRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
