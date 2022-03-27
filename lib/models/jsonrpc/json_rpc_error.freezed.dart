// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'json_rpc_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JsonRpcError _$JsonRpcErrorFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'default':
      return RpcError.fromJson(json);
    case 'serverError':
      return ServerError.fromJson(json);
    case 'invalidParams':
      return InvalidParams.fromJson(json);
    case 'invalidRequest':
      return InvalidRequest.fromJson(json);
    case 'parseError':
      return ParseError.fromJson(json);
    case 'methodNotFound':
      return MethodNotFound.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'JsonRpcError',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
class _$JsonRpcErrorTearOff {
  const _$JsonRpcErrorTearOff();

  RpcError call(int code, String message) {
    return RpcError(
      code,
      message,
    );
  }

  ServerError serverError(String message, {int code = -32000}) {
    return ServerError(
      message,
      code: code,
    );
  }

  InvalidParams invalidParams(String message, {int code = -32602}) {
    return InvalidParams(
      message,
      code: code,
    );
  }

  InvalidRequest invalidRequest(String message, {int code = -32600}) {
    return InvalidRequest(
      message,
      code: code,
    );
  }

  ParseError parseError(String message, {int code = -32700}) {
    return ParseError(
      message,
      code: code,
    );
  }

  MethodNotFound methodNotFound(String message, {int code = -32601}) {
    return MethodNotFound(
      message,
      code: code,
    );
  }

  JsonRpcError fromJson(Map<String, Object?> json) {
    return JsonRpcError.fromJson(json);
  }
}

/// @nodoc
const $JsonRpcError = _$JsonRpcErrorTearOff();

/// @nodoc
mixin _$JsonRpcError {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int code, String message) $default, {
    required TResult Function(String message, int code) serverError,
    required TResult Function(String message, int code) invalidParams,
    required TResult Function(String message, int code) invalidRequest,
    required TResult Function(String message, int code) parseError,
    required TResult Function(String message, int code) methodNotFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RpcError value) $default, {
    required TResult Function(ServerError value) serverError,
    required TResult Function(InvalidParams value) invalidParams,
    required TResult Function(InvalidRequest value) invalidRequest,
    required TResult Function(ParseError value) parseError,
    required TResult Function(MethodNotFound value) methodNotFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonRpcErrorCopyWith<JsonRpcError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonRpcErrorCopyWith<$Res> {
  factory $JsonRpcErrorCopyWith(
          JsonRpcError value, $Res Function(JsonRpcError) then) =
      _$JsonRpcErrorCopyWithImpl<$Res>;
  $Res call({int code, String message});
}

/// @nodoc
class _$JsonRpcErrorCopyWithImpl<$Res> implements $JsonRpcErrorCopyWith<$Res> {
  _$JsonRpcErrorCopyWithImpl(this._value, this._then);

  final JsonRpcError _value;
  // ignore: unused_field
  final $Res Function(JsonRpcError) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $RpcErrorCopyWith<$Res> implements $JsonRpcErrorCopyWith<$Res> {
  factory $RpcErrorCopyWith(RpcError value, $Res Function(RpcError) then) =
      _$RpcErrorCopyWithImpl<$Res>;
  @override
  $Res call({int code, String message});
}

/// @nodoc
class _$RpcErrorCopyWithImpl<$Res> extends _$JsonRpcErrorCopyWithImpl<$Res>
    implements $RpcErrorCopyWith<$Res> {
  _$RpcErrorCopyWithImpl(RpcError _value, $Res Function(RpcError) _then)
      : super(_value, (v) => _then(v as RpcError));

  @override
  RpcError get _value => super._value as RpcError;

  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
  }) {
    return _then(RpcError(
      code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RpcError extends RpcError {
  const _$RpcError(this.code, this.message, {String? $type})
      : $type = $type ?? 'default',
        super._();

  factory _$RpcError.fromJson(Map<String, dynamic> json) =>
      _$$RpcErrorFromJson(json);

  @override
  final int code;
  @override
  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'JsonRpcError(code: $code, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RpcError &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  $RpcErrorCopyWith<RpcError> get copyWith =>
      _$RpcErrorCopyWithImpl<RpcError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int code, String message) $default, {
    required TResult Function(String message, int code) serverError,
    required TResult Function(String message, int code) invalidParams,
    required TResult Function(String message, int code) invalidRequest,
    required TResult Function(String message, int code) parseError,
    required TResult Function(String message, int code) methodNotFound,
  }) {
    return $default(code, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
  }) {
    return $default?.call(code, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(code, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RpcError value) $default, {
    required TResult Function(ServerError value) serverError,
    required TResult Function(InvalidParams value) invalidParams,
    required TResult Function(InvalidRequest value) invalidRequest,
    required TResult Function(ParseError value) parseError,
    required TResult Function(MethodNotFound value) methodNotFound,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RpcErrorToJson(this);
  }
}

abstract class RpcError extends JsonRpcError {
  const factory RpcError(int code, String message) = _$RpcError;
  const RpcError._() : super._();

  factory RpcError.fromJson(Map<String, dynamic> json) = _$RpcError.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  $RpcErrorCopyWith<RpcError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerErrorCopyWith<$Res>
    implements $JsonRpcErrorCopyWith<$Res> {
  factory $ServerErrorCopyWith(
          ServerError value, $Res Function(ServerError) then) =
      _$ServerErrorCopyWithImpl<$Res>;
  @override
  $Res call({String message, int code});
}

/// @nodoc
class _$ServerErrorCopyWithImpl<$Res> extends _$JsonRpcErrorCopyWithImpl<$Res>
    implements $ServerErrorCopyWith<$Res> {
  _$ServerErrorCopyWithImpl(
      ServerError _value, $Res Function(ServerError) _then)
      : super(_value, (v) => _then(v as ServerError));

  @override
  ServerError get _value => super._value as ServerError;

  @override
  $Res call({
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(ServerError(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerError extends ServerError {
  const _$ServerError(this.message, {this.code = -32000, String? $type})
      : $type = $type ?? 'serverError',
        super._();

  factory _$ServerError.fromJson(Map<String, dynamic> json) =>
      _$$ServerErrorFromJson(json);

  @override
  final String message;
  @JsonKey()
  @override
  final int code;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'JsonRpcError.serverError(message: $message, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ServerError &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(code));

  @JsonKey(ignore: true)
  @override
  $ServerErrorCopyWith<ServerError> get copyWith =>
      _$ServerErrorCopyWithImpl<ServerError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int code, String message) $default, {
    required TResult Function(String message, int code) serverError,
    required TResult Function(String message, int code) invalidParams,
    required TResult Function(String message, int code) invalidRequest,
    required TResult Function(String message, int code) parseError,
    required TResult Function(String message, int code) methodNotFound,
  }) {
    return serverError(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
  }) {
    return serverError?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RpcError value) $default, {
    required TResult Function(ServerError value) serverError,
    required TResult Function(InvalidParams value) invalidParams,
    required TResult Function(InvalidRequest value) invalidRequest,
    required TResult Function(ParseError value) parseError,
    required TResult Function(MethodNotFound value) methodNotFound,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerErrorToJson(this);
  }
}

abstract class ServerError extends JsonRpcError {
  const factory ServerError(String message, {int code}) = _$ServerError;
  const ServerError._() : super._();

  factory ServerError.fromJson(Map<String, dynamic> json) =
      _$ServerError.fromJson;

  @override
  String get message;
  @override
  int get code;
  @override
  @JsonKey(ignore: true)
  $ServerErrorCopyWith<ServerError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvalidParamsCopyWith<$Res>
    implements $JsonRpcErrorCopyWith<$Res> {
  factory $InvalidParamsCopyWith(
          InvalidParams value, $Res Function(InvalidParams) then) =
      _$InvalidParamsCopyWithImpl<$Res>;
  @override
  $Res call({String message, int code});
}

/// @nodoc
class _$InvalidParamsCopyWithImpl<$Res> extends _$JsonRpcErrorCopyWithImpl<$Res>
    implements $InvalidParamsCopyWith<$Res> {
  _$InvalidParamsCopyWithImpl(
      InvalidParams _value, $Res Function(InvalidParams) _then)
      : super(_value, (v) => _then(v as InvalidParams));

  @override
  InvalidParams get _value => super._value as InvalidParams;

  @override
  $Res call({
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(InvalidParams(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvalidParams extends InvalidParams {
  const _$InvalidParams(this.message, {this.code = -32602, String? $type})
      : $type = $type ?? 'invalidParams',
        super._();

  factory _$InvalidParams.fromJson(Map<String, dynamic> json) =>
      _$$InvalidParamsFromJson(json);

  @override
  final String message;
  @JsonKey()
  @override
  final int code;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'JsonRpcError.invalidParams(message: $message, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InvalidParams &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(code));

  @JsonKey(ignore: true)
  @override
  $InvalidParamsCopyWith<InvalidParams> get copyWith =>
      _$InvalidParamsCopyWithImpl<InvalidParams>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int code, String message) $default, {
    required TResult Function(String message, int code) serverError,
    required TResult Function(String message, int code) invalidParams,
    required TResult Function(String message, int code) invalidRequest,
    required TResult Function(String message, int code) parseError,
    required TResult Function(String message, int code) methodNotFound,
  }) {
    return invalidParams(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
  }) {
    return invalidParams?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
    required TResult orElse(),
  }) {
    if (invalidParams != null) {
      return invalidParams(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RpcError value) $default, {
    required TResult Function(ServerError value) serverError,
    required TResult Function(InvalidParams value) invalidParams,
    required TResult Function(InvalidRequest value) invalidRequest,
    required TResult Function(ParseError value) parseError,
    required TResult Function(MethodNotFound value) methodNotFound,
  }) {
    return invalidParams(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
  }) {
    return invalidParams?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
    required TResult orElse(),
  }) {
    if (invalidParams != null) {
      return invalidParams(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InvalidParamsToJson(this);
  }
}

abstract class InvalidParams extends JsonRpcError {
  const factory InvalidParams(String message, {int code}) = _$InvalidParams;
  const InvalidParams._() : super._();

  factory InvalidParams.fromJson(Map<String, dynamic> json) =
      _$InvalidParams.fromJson;

  @override
  String get message;
  @override
  int get code;
  @override
  @JsonKey(ignore: true)
  $InvalidParamsCopyWith<InvalidParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvalidRequestCopyWith<$Res>
    implements $JsonRpcErrorCopyWith<$Res> {
  factory $InvalidRequestCopyWith(
          InvalidRequest value, $Res Function(InvalidRequest) then) =
      _$InvalidRequestCopyWithImpl<$Res>;
  @override
  $Res call({String message, int code});
}

/// @nodoc
class _$InvalidRequestCopyWithImpl<$Res>
    extends _$JsonRpcErrorCopyWithImpl<$Res>
    implements $InvalidRequestCopyWith<$Res> {
  _$InvalidRequestCopyWithImpl(
      InvalidRequest _value, $Res Function(InvalidRequest) _then)
      : super(_value, (v) => _then(v as InvalidRequest));

  @override
  InvalidRequest get _value => super._value as InvalidRequest;

  @override
  $Res call({
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(InvalidRequest(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvalidRequest extends InvalidRequest {
  const _$InvalidRequest(this.message, {this.code = -32600, String? $type})
      : $type = $type ?? 'invalidRequest',
        super._();

  factory _$InvalidRequest.fromJson(Map<String, dynamic> json) =>
      _$$InvalidRequestFromJson(json);

  @override
  final String message;
  @JsonKey()
  @override
  final int code;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'JsonRpcError.invalidRequest(message: $message, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InvalidRequest &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(code));

  @JsonKey(ignore: true)
  @override
  $InvalidRequestCopyWith<InvalidRequest> get copyWith =>
      _$InvalidRequestCopyWithImpl<InvalidRequest>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int code, String message) $default, {
    required TResult Function(String message, int code) serverError,
    required TResult Function(String message, int code) invalidParams,
    required TResult Function(String message, int code) invalidRequest,
    required TResult Function(String message, int code) parseError,
    required TResult Function(String message, int code) methodNotFound,
  }) {
    return invalidRequest(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
  }) {
    return invalidRequest?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
    required TResult orElse(),
  }) {
    if (invalidRequest != null) {
      return invalidRequest(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RpcError value) $default, {
    required TResult Function(ServerError value) serverError,
    required TResult Function(InvalidParams value) invalidParams,
    required TResult Function(InvalidRequest value) invalidRequest,
    required TResult Function(ParseError value) parseError,
    required TResult Function(MethodNotFound value) methodNotFound,
  }) {
    return invalidRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
  }) {
    return invalidRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
    required TResult orElse(),
  }) {
    if (invalidRequest != null) {
      return invalidRequest(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InvalidRequestToJson(this);
  }
}

abstract class InvalidRequest extends JsonRpcError {
  const factory InvalidRequest(String message, {int code}) = _$InvalidRequest;
  const InvalidRequest._() : super._();

  factory InvalidRequest.fromJson(Map<String, dynamic> json) =
      _$InvalidRequest.fromJson;

  @override
  String get message;
  @override
  int get code;
  @override
  @JsonKey(ignore: true)
  $InvalidRequestCopyWith<InvalidRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParseErrorCopyWith<$Res>
    implements $JsonRpcErrorCopyWith<$Res> {
  factory $ParseErrorCopyWith(
          ParseError value, $Res Function(ParseError) then) =
      _$ParseErrorCopyWithImpl<$Res>;
  @override
  $Res call({String message, int code});
}

/// @nodoc
class _$ParseErrorCopyWithImpl<$Res> extends _$JsonRpcErrorCopyWithImpl<$Res>
    implements $ParseErrorCopyWith<$Res> {
  _$ParseErrorCopyWithImpl(ParseError _value, $Res Function(ParseError) _then)
      : super(_value, (v) => _then(v as ParseError));

  @override
  ParseError get _value => super._value as ParseError;

  @override
  $Res call({
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(ParseError(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParseError extends ParseError {
  const _$ParseError(this.message, {this.code = -32700, String? $type})
      : $type = $type ?? 'parseError',
        super._();

  factory _$ParseError.fromJson(Map<String, dynamic> json) =>
      _$$ParseErrorFromJson(json);

  @override
  final String message;
  @JsonKey()
  @override
  final int code;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'JsonRpcError.parseError(message: $message, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ParseError &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(code));

  @JsonKey(ignore: true)
  @override
  $ParseErrorCopyWith<ParseError> get copyWith =>
      _$ParseErrorCopyWithImpl<ParseError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int code, String message) $default, {
    required TResult Function(String message, int code) serverError,
    required TResult Function(String message, int code) invalidParams,
    required TResult Function(String message, int code) invalidRequest,
    required TResult Function(String message, int code) parseError,
    required TResult Function(String message, int code) methodNotFound,
  }) {
    return parseError(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
  }) {
    return parseError?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
    required TResult orElse(),
  }) {
    if (parseError != null) {
      return parseError(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RpcError value) $default, {
    required TResult Function(ServerError value) serverError,
    required TResult Function(InvalidParams value) invalidParams,
    required TResult Function(InvalidRequest value) invalidRequest,
    required TResult Function(ParseError value) parseError,
    required TResult Function(MethodNotFound value) methodNotFound,
  }) {
    return parseError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
  }) {
    return parseError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
    required TResult orElse(),
  }) {
    if (parseError != null) {
      return parseError(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ParseErrorToJson(this);
  }
}

abstract class ParseError extends JsonRpcError {
  const factory ParseError(String message, {int code}) = _$ParseError;
  const ParseError._() : super._();

  factory ParseError.fromJson(Map<String, dynamic> json) =
      _$ParseError.fromJson;

  @override
  String get message;
  @override
  int get code;
  @override
  @JsonKey(ignore: true)
  $ParseErrorCopyWith<ParseError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MethodNotFoundCopyWith<$Res>
    implements $JsonRpcErrorCopyWith<$Res> {
  factory $MethodNotFoundCopyWith(
          MethodNotFound value, $Res Function(MethodNotFound) then) =
      _$MethodNotFoundCopyWithImpl<$Res>;
  @override
  $Res call({String message, int code});
}

/// @nodoc
class _$MethodNotFoundCopyWithImpl<$Res>
    extends _$JsonRpcErrorCopyWithImpl<$Res>
    implements $MethodNotFoundCopyWith<$Res> {
  _$MethodNotFoundCopyWithImpl(
      MethodNotFound _value, $Res Function(MethodNotFound) _then)
      : super(_value, (v) => _then(v as MethodNotFound));

  @override
  MethodNotFound get _value => super._value as MethodNotFound;

  @override
  $Res call({
    Object? message = freezed,
    Object? code = freezed,
  }) {
    return _then(MethodNotFound(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MethodNotFound extends MethodNotFound {
  const _$MethodNotFound(this.message, {this.code = -32601, String? $type})
      : $type = $type ?? 'methodNotFound',
        super._();

  factory _$MethodNotFound.fromJson(Map<String, dynamic> json) =>
      _$$MethodNotFoundFromJson(json);

  @override
  final String message;
  @JsonKey()
  @override
  final int code;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'JsonRpcError.methodNotFound(message: $message, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MethodNotFound &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.code, code));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(code));

  @JsonKey(ignore: true)
  @override
  $MethodNotFoundCopyWith<MethodNotFound> get copyWith =>
      _$MethodNotFoundCopyWithImpl<MethodNotFound>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int code, String message) $default, {
    required TResult Function(String message, int code) serverError,
    required TResult Function(String message, int code) invalidParams,
    required TResult Function(String message, int code) invalidRequest,
    required TResult Function(String message, int code) parseError,
    required TResult Function(String message, int code) methodNotFound,
  }) {
    return methodNotFound(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
  }) {
    return methodNotFound?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int code, String message)? $default, {
    TResult Function(String message, int code)? serverError,
    TResult Function(String message, int code)? invalidParams,
    TResult Function(String message, int code)? invalidRequest,
    TResult Function(String message, int code)? parseError,
    TResult Function(String message, int code)? methodNotFound,
    required TResult orElse(),
  }) {
    if (methodNotFound != null) {
      return methodNotFound(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(RpcError value) $default, {
    required TResult Function(ServerError value) serverError,
    required TResult Function(InvalidParams value) invalidParams,
    required TResult Function(InvalidRequest value) invalidRequest,
    required TResult Function(ParseError value) parseError,
    required TResult Function(MethodNotFound value) methodNotFound,
  }) {
    return methodNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
  }) {
    return methodNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(RpcError value)? $default, {
    TResult Function(ServerError value)? serverError,
    TResult Function(InvalidParams value)? invalidParams,
    TResult Function(InvalidRequest value)? invalidRequest,
    TResult Function(ParseError value)? parseError,
    TResult Function(MethodNotFound value)? methodNotFound,
    required TResult orElse(),
  }) {
    if (methodNotFound != null) {
      return methodNotFound(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MethodNotFoundToJson(this);
  }
}

abstract class MethodNotFound extends JsonRpcError {
  const factory MethodNotFound(String message, {int code}) = _$MethodNotFound;
  const MethodNotFound._() : super._();

  factory MethodNotFound.fromJson(Map<String, dynamic> json) =
      _$MethodNotFound.fromJson;

  @override
  String get message;
  @override
  int get code;
  @override
  @JsonKey(ignore: true)
  $MethodNotFoundCopyWith<MethodNotFound> get copyWith =>
      throw _privateConstructorUsedError;
}
