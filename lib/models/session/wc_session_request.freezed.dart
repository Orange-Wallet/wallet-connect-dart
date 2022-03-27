// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wc_session_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WCSessionRequest _$WCSessionRequestFromJson(Map<String, dynamic> json) {
  return _WCSessionRequest.fromJson(json);
}

/// @nodoc
class _$WCSessionRequestTearOff {
  const _$WCSessionRequestTearOff();

  _WCSessionRequest call(
      {required String peerId, required WCPeerMeta peerMeta, int? chainId}) {
    return _WCSessionRequest(
      peerId: peerId,
      peerMeta: peerMeta,
      chainId: chainId,
    );
  }

  WCSessionRequest fromJson(Map<String, Object?> json) {
    return WCSessionRequest.fromJson(json);
  }
}

/// @nodoc
const $WCSessionRequest = _$WCSessionRequestTearOff();

/// @nodoc
mixin _$WCSessionRequest {
  String get peerId => throw _privateConstructorUsedError;
  WCPeerMeta get peerMeta => throw _privateConstructorUsedError;
  int? get chainId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WCSessionRequestCopyWith<WCSessionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WCSessionRequestCopyWith<$Res> {
  factory $WCSessionRequestCopyWith(
          WCSessionRequest value, $Res Function(WCSessionRequest) then) =
      _$WCSessionRequestCopyWithImpl<$Res>;
  $Res call({String peerId, WCPeerMeta peerMeta, int? chainId});

  $WCPeerMetaCopyWith<$Res> get peerMeta;
}

/// @nodoc
class _$WCSessionRequestCopyWithImpl<$Res>
    implements $WCSessionRequestCopyWith<$Res> {
  _$WCSessionRequestCopyWithImpl(this._value, this._then);

  final WCSessionRequest _value;
  // ignore: unused_field
  final $Res Function(WCSessionRequest) _then;

  @override
  $Res call({
    Object? peerId = freezed,
    Object? peerMeta = freezed,
    Object? chainId = freezed,
  }) {
    return _then(_value.copyWith(
      peerId: peerId == freezed
          ? _value.peerId
          : peerId // ignore: cast_nullable_to_non_nullable
              as String,
      peerMeta: peerMeta == freezed
          ? _value.peerMeta
          : peerMeta // ignore: cast_nullable_to_non_nullable
              as WCPeerMeta,
      chainId: chainId == freezed
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  @override
  $WCPeerMetaCopyWith<$Res> get peerMeta {
    return $WCPeerMetaCopyWith<$Res>(_value.peerMeta, (value) {
      return _then(_value.copyWith(peerMeta: value));
    });
  }
}

/// @nodoc
abstract class _$WCSessionRequestCopyWith<$Res>
    implements $WCSessionRequestCopyWith<$Res> {
  factory _$WCSessionRequestCopyWith(
          _WCSessionRequest value, $Res Function(_WCSessionRequest) then) =
      __$WCSessionRequestCopyWithImpl<$Res>;
  @override
  $Res call({String peerId, WCPeerMeta peerMeta, int? chainId});

  @override
  $WCPeerMetaCopyWith<$Res> get peerMeta;
}

/// @nodoc
class __$WCSessionRequestCopyWithImpl<$Res>
    extends _$WCSessionRequestCopyWithImpl<$Res>
    implements _$WCSessionRequestCopyWith<$Res> {
  __$WCSessionRequestCopyWithImpl(
      _WCSessionRequest _value, $Res Function(_WCSessionRequest) _then)
      : super(_value, (v) => _then(v as _WCSessionRequest));

  @override
  _WCSessionRequest get _value => super._value as _WCSessionRequest;

  @override
  $Res call({
    Object? peerId = freezed,
    Object? peerMeta = freezed,
    Object? chainId = freezed,
  }) {
    return _then(_WCSessionRequest(
      peerId: peerId == freezed
          ? _value.peerId
          : peerId // ignore: cast_nullable_to_non_nullable
              as String,
      peerMeta: peerMeta == freezed
          ? _value.peerMeta
          : peerMeta // ignore: cast_nullable_to_non_nullable
              as WCPeerMeta,
      chainId: chainId == freezed
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WCSessionRequest implements _WCSessionRequest {
  _$_WCSessionRequest(
      {required this.peerId, required this.peerMeta, this.chainId});

  factory _$_WCSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WCSessionRequestFromJson(json);

  @override
  final String peerId;
  @override
  final WCPeerMeta peerMeta;
  @override
  final int? chainId;

  @override
  String toString() {
    return 'WCSessionRequest(peerId: $peerId, peerMeta: $peerMeta, chainId: $chainId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WCSessionRequest &&
            const DeepCollectionEquality().equals(other.peerId, peerId) &&
            const DeepCollectionEquality().equals(other.peerMeta, peerMeta) &&
            const DeepCollectionEquality().equals(other.chainId, chainId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(peerId),
      const DeepCollectionEquality().hash(peerMeta),
      const DeepCollectionEquality().hash(chainId));

  @JsonKey(ignore: true)
  @override
  _$WCSessionRequestCopyWith<_WCSessionRequest> get copyWith =>
      __$WCSessionRequestCopyWithImpl<_WCSessionRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WCSessionRequestToJson(this);
  }
}

abstract class _WCSessionRequest implements WCSessionRequest {
  factory _WCSessionRequest(
      {required String peerId,
      required WCPeerMeta peerMeta,
      int? chainId}) = _$_WCSessionRequest;

  factory _WCSessionRequest.fromJson(Map<String, dynamic> json) =
      _$_WCSessionRequest.fromJson;

  @override
  String get peerId;
  @override
  WCPeerMeta get peerMeta;
  @override
  int? get chainId;
  @override
  @JsonKey(ignore: true)
  _$WCSessionRequestCopyWith<_WCSessionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
