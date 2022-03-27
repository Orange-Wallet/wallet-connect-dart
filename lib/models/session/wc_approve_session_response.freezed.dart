// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wc_approve_session_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WCApproveSessionResponse _$WCApproveSessionResponseFromJson(
    Map<String, dynamic> json) {
  return _WCApproveSessionResponse.fromJson(json);
}

/// @nodoc
class _$WCApproveSessionResponseTearOff {
  const _$WCApproveSessionResponseTearOff();

  _WCApproveSessionResponse call(
      {bool approved = true,
      int? chainId,
      required List<String> accounts,
      required String peerId,
      required WCPeerMeta peerMeta}) {
    return _WCApproveSessionResponse(
      approved: approved,
      chainId: chainId,
      accounts: accounts,
      peerId: peerId,
      peerMeta: peerMeta,
    );
  }

  WCApproveSessionResponse fromJson(Map<String, Object?> json) {
    return WCApproveSessionResponse.fromJson(json);
  }
}

/// @nodoc
const $WCApproveSessionResponse = _$WCApproveSessionResponseTearOff();

/// @nodoc
mixin _$WCApproveSessionResponse {
  bool get approved => throw _privateConstructorUsedError;
  int? get chainId => throw _privateConstructorUsedError;
  List<String> get accounts => throw _privateConstructorUsedError;
  String get peerId => throw _privateConstructorUsedError;
  WCPeerMeta get peerMeta => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WCApproveSessionResponseCopyWith<WCApproveSessionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WCApproveSessionResponseCopyWith<$Res> {
  factory $WCApproveSessionResponseCopyWith(WCApproveSessionResponse value,
          $Res Function(WCApproveSessionResponse) then) =
      _$WCApproveSessionResponseCopyWithImpl<$Res>;
  $Res call(
      {bool approved,
      int? chainId,
      List<String> accounts,
      String peerId,
      WCPeerMeta peerMeta});

  $WCPeerMetaCopyWith<$Res> get peerMeta;
}

/// @nodoc
class _$WCApproveSessionResponseCopyWithImpl<$Res>
    implements $WCApproveSessionResponseCopyWith<$Res> {
  _$WCApproveSessionResponseCopyWithImpl(this._value, this._then);

  final WCApproveSessionResponse _value;
  // ignore: unused_field
  final $Res Function(WCApproveSessionResponse) _then;

  @override
  $Res call({
    Object? approved = freezed,
    Object? chainId = freezed,
    Object? accounts = freezed,
    Object? peerId = freezed,
    Object? peerMeta = freezed,
  }) {
    return _then(_value.copyWith(
      approved: approved == freezed
          ? _value.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
      chainId: chainId == freezed
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      accounts: accounts == freezed
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      peerId: peerId == freezed
          ? _value.peerId
          : peerId // ignore: cast_nullable_to_non_nullable
              as String,
      peerMeta: peerMeta == freezed
          ? _value.peerMeta
          : peerMeta // ignore: cast_nullable_to_non_nullable
              as WCPeerMeta,
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
abstract class _$WCApproveSessionResponseCopyWith<$Res>
    implements $WCApproveSessionResponseCopyWith<$Res> {
  factory _$WCApproveSessionResponseCopyWith(_WCApproveSessionResponse value,
          $Res Function(_WCApproveSessionResponse) then) =
      __$WCApproveSessionResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool approved,
      int? chainId,
      List<String> accounts,
      String peerId,
      WCPeerMeta peerMeta});

  @override
  $WCPeerMetaCopyWith<$Res> get peerMeta;
}

/// @nodoc
class __$WCApproveSessionResponseCopyWithImpl<$Res>
    extends _$WCApproveSessionResponseCopyWithImpl<$Res>
    implements _$WCApproveSessionResponseCopyWith<$Res> {
  __$WCApproveSessionResponseCopyWithImpl(_WCApproveSessionResponse _value,
      $Res Function(_WCApproveSessionResponse) _then)
      : super(_value, (v) => _then(v as _WCApproveSessionResponse));

  @override
  _WCApproveSessionResponse get _value =>
      super._value as _WCApproveSessionResponse;

  @override
  $Res call({
    Object? approved = freezed,
    Object? chainId = freezed,
    Object? accounts = freezed,
    Object? peerId = freezed,
    Object? peerMeta = freezed,
  }) {
    return _then(_WCApproveSessionResponse(
      approved: approved == freezed
          ? _value.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
      chainId: chainId == freezed
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      accounts: accounts == freezed
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      peerId: peerId == freezed
          ? _value.peerId
          : peerId // ignore: cast_nullable_to_non_nullable
              as String,
      peerMeta: peerMeta == freezed
          ? _value.peerMeta
          : peerMeta // ignore: cast_nullable_to_non_nullable
              as WCPeerMeta,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WCApproveSessionResponse implements _WCApproveSessionResponse {
  _$_WCApproveSessionResponse(
      {this.approved = true,
      this.chainId,
      required this.accounts,
      required this.peerId,
      required this.peerMeta});

  factory _$_WCApproveSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$$_WCApproveSessionResponseFromJson(json);

  @JsonKey()
  @override
  final bool approved;
  @override
  final int? chainId;
  @override
  final List<String> accounts;
  @override
  final String peerId;
  @override
  final WCPeerMeta peerMeta;

  @override
  String toString() {
    return 'WCApproveSessionResponse(approved: $approved, chainId: $chainId, accounts: $accounts, peerId: $peerId, peerMeta: $peerMeta)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WCApproveSessionResponse &&
            const DeepCollectionEquality().equals(other.approved, approved) &&
            const DeepCollectionEquality().equals(other.chainId, chainId) &&
            const DeepCollectionEquality().equals(other.accounts, accounts) &&
            const DeepCollectionEquality().equals(other.peerId, peerId) &&
            const DeepCollectionEquality().equals(other.peerMeta, peerMeta));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(approved),
      const DeepCollectionEquality().hash(chainId),
      const DeepCollectionEquality().hash(accounts),
      const DeepCollectionEquality().hash(peerId),
      const DeepCollectionEquality().hash(peerMeta));

  @JsonKey(ignore: true)
  @override
  _$WCApproveSessionResponseCopyWith<_WCApproveSessionResponse> get copyWith =>
      __$WCApproveSessionResponseCopyWithImpl<_WCApproveSessionResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WCApproveSessionResponseToJson(this);
  }
}

abstract class _WCApproveSessionResponse implements WCApproveSessionResponse {
  factory _WCApproveSessionResponse(
      {bool approved,
      int? chainId,
      required List<String> accounts,
      required String peerId,
      required WCPeerMeta peerMeta}) = _$_WCApproveSessionResponse;

  factory _WCApproveSessionResponse.fromJson(Map<String, dynamic> json) =
      _$_WCApproveSessionResponse.fromJson;

  @override
  bool get approved;
  @override
  int? get chainId;
  @override
  List<String> get accounts;
  @override
  String get peerId;
  @override
  WCPeerMeta get peerMeta;
  @override
  @JsonKey(ignore: true)
  _$WCApproveSessionResponseCopyWith<_WCApproveSessionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
