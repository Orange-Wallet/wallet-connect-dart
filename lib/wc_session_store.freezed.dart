// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wc_session_store.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WCSessionStore _$WCSessionStoreFromJson(Map<String, dynamic> json) {
  return _WCSessionStore.fromJson(json);
}

/// @nodoc
class _$WCSessionStoreTearOff {
  const _$WCSessionStoreTearOff();

  _WCSessionStore call(
      {required WCSession session,
      required WCPeerMeta peerMeta,
      required WCPeerMeta remotePeerMeta,
      required int chainId,
      required String peerId,
      required String remotePeerId}) {
    return _WCSessionStore(
      session: session,
      peerMeta: peerMeta,
      remotePeerMeta: remotePeerMeta,
      chainId: chainId,
      peerId: peerId,
      remotePeerId: remotePeerId,
    );
  }

  WCSessionStore fromJson(Map<String, Object?> json) {
    return WCSessionStore.fromJson(json);
  }
}

/// @nodoc
const $WCSessionStore = _$WCSessionStoreTearOff();

/// @nodoc
mixin _$WCSessionStore {
  WCSession get session => throw _privateConstructorUsedError;
  WCPeerMeta get peerMeta => throw _privateConstructorUsedError;
  WCPeerMeta get remotePeerMeta => throw _privateConstructorUsedError;
  int get chainId => throw _privateConstructorUsedError;
  String get peerId => throw _privateConstructorUsedError;
  String get remotePeerId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WCSessionStoreCopyWith<WCSessionStore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WCSessionStoreCopyWith<$Res> {
  factory $WCSessionStoreCopyWith(
          WCSessionStore value, $Res Function(WCSessionStore) then) =
      _$WCSessionStoreCopyWithImpl<$Res>;
  $Res call(
      {WCSession session,
      WCPeerMeta peerMeta,
      WCPeerMeta remotePeerMeta,
      int chainId,
      String peerId,
      String remotePeerId});

  $WCSessionCopyWith<$Res> get session;
  $WCPeerMetaCopyWith<$Res> get peerMeta;
  $WCPeerMetaCopyWith<$Res> get remotePeerMeta;
}

/// @nodoc
class _$WCSessionStoreCopyWithImpl<$Res>
    implements $WCSessionStoreCopyWith<$Res> {
  _$WCSessionStoreCopyWithImpl(this._value, this._then);

  final WCSessionStore _value;
  // ignore: unused_field
  final $Res Function(WCSessionStore) _then;

  @override
  $Res call({
    Object? session = freezed,
    Object? peerMeta = freezed,
    Object? remotePeerMeta = freezed,
    Object? chainId = freezed,
    Object? peerId = freezed,
    Object? remotePeerId = freezed,
  }) {
    return _then(_value.copyWith(
      session: session == freezed
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as WCSession,
      peerMeta: peerMeta == freezed
          ? _value.peerMeta
          : peerMeta // ignore: cast_nullable_to_non_nullable
              as WCPeerMeta,
      remotePeerMeta: remotePeerMeta == freezed
          ? _value.remotePeerMeta
          : remotePeerMeta // ignore: cast_nullable_to_non_nullable
              as WCPeerMeta,
      chainId: chainId == freezed
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      peerId: peerId == freezed
          ? _value.peerId
          : peerId // ignore: cast_nullable_to_non_nullable
              as String,
      remotePeerId: remotePeerId == freezed
          ? _value.remotePeerId
          : remotePeerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $WCSessionCopyWith<$Res> get session {
    return $WCSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }

  @override
  $WCPeerMetaCopyWith<$Res> get peerMeta {
    return $WCPeerMetaCopyWith<$Res>(_value.peerMeta, (value) {
      return _then(_value.copyWith(peerMeta: value));
    });
  }

  @override
  $WCPeerMetaCopyWith<$Res> get remotePeerMeta {
    return $WCPeerMetaCopyWith<$Res>(_value.remotePeerMeta, (value) {
      return _then(_value.copyWith(remotePeerMeta: value));
    });
  }
}

/// @nodoc
abstract class _$WCSessionStoreCopyWith<$Res>
    implements $WCSessionStoreCopyWith<$Res> {
  factory _$WCSessionStoreCopyWith(
          _WCSessionStore value, $Res Function(_WCSessionStore) then) =
      __$WCSessionStoreCopyWithImpl<$Res>;
  @override
  $Res call(
      {WCSession session,
      WCPeerMeta peerMeta,
      WCPeerMeta remotePeerMeta,
      int chainId,
      String peerId,
      String remotePeerId});

  @override
  $WCSessionCopyWith<$Res> get session;
  @override
  $WCPeerMetaCopyWith<$Res> get peerMeta;
  @override
  $WCPeerMetaCopyWith<$Res> get remotePeerMeta;
}

/// @nodoc
class __$WCSessionStoreCopyWithImpl<$Res>
    extends _$WCSessionStoreCopyWithImpl<$Res>
    implements _$WCSessionStoreCopyWith<$Res> {
  __$WCSessionStoreCopyWithImpl(
      _WCSessionStore _value, $Res Function(_WCSessionStore) _then)
      : super(_value, (v) => _then(v as _WCSessionStore));

  @override
  _WCSessionStore get _value => super._value as _WCSessionStore;

  @override
  $Res call({
    Object? session = freezed,
    Object? peerMeta = freezed,
    Object? remotePeerMeta = freezed,
    Object? chainId = freezed,
    Object? peerId = freezed,
    Object? remotePeerId = freezed,
  }) {
    return _then(_WCSessionStore(
      session: session == freezed
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as WCSession,
      peerMeta: peerMeta == freezed
          ? _value.peerMeta
          : peerMeta // ignore: cast_nullable_to_non_nullable
              as WCPeerMeta,
      remotePeerMeta: remotePeerMeta == freezed
          ? _value.remotePeerMeta
          : remotePeerMeta // ignore: cast_nullable_to_non_nullable
              as WCPeerMeta,
      chainId: chainId == freezed
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      peerId: peerId == freezed
          ? _value.peerId
          : peerId // ignore: cast_nullable_to_non_nullable
              as String,
      remotePeerId: remotePeerId == freezed
          ? _value.remotePeerId
          : remotePeerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WCSessionStore implements _WCSessionStore {
  _$_WCSessionStore(
      {required this.session,
      required this.peerMeta,
      required this.remotePeerMeta,
      required this.chainId,
      required this.peerId,
      required this.remotePeerId});

  factory _$_WCSessionStore.fromJson(Map<String, dynamic> json) =>
      _$$_WCSessionStoreFromJson(json);

  @override
  final WCSession session;
  @override
  final WCPeerMeta peerMeta;
  @override
  final WCPeerMeta remotePeerMeta;
  @override
  final int chainId;
  @override
  final String peerId;
  @override
  final String remotePeerId;

  @override
  String toString() {
    return 'WCSessionStore(session: $session, peerMeta: $peerMeta, remotePeerMeta: $remotePeerMeta, chainId: $chainId, peerId: $peerId, remotePeerId: $remotePeerId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WCSessionStore &&
            const DeepCollectionEquality().equals(other.session, session) &&
            const DeepCollectionEquality().equals(other.peerMeta, peerMeta) &&
            const DeepCollectionEquality()
                .equals(other.remotePeerMeta, remotePeerMeta) &&
            const DeepCollectionEquality().equals(other.chainId, chainId) &&
            const DeepCollectionEquality().equals(other.peerId, peerId) &&
            const DeepCollectionEquality()
                .equals(other.remotePeerId, remotePeerId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(session),
      const DeepCollectionEquality().hash(peerMeta),
      const DeepCollectionEquality().hash(remotePeerMeta),
      const DeepCollectionEquality().hash(chainId),
      const DeepCollectionEquality().hash(peerId),
      const DeepCollectionEquality().hash(remotePeerId));

  @JsonKey(ignore: true)
  @override
  _$WCSessionStoreCopyWith<_WCSessionStore> get copyWith =>
      __$WCSessionStoreCopyWithImpl<_WCSessionStore>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WCSessionStoreToJson(this);
  }
}

abstract class _WCSessionStore implements WCSessionStore {
  factory _WCSessionStore(
      {required WCSession session,
      required WCPeerMeta peerMeta,
      required WCPeerMeta remotePeerMeta,
      required int chainId,
      required String peerId,
      required String remotePeerId}) = _$_WCSessionStore;

  factory _WCSessionStore.fromJson(Map<String, dynamic> json) =
      _$_WCSessionStore.fromJson;

  @override
  WCSession get session;
  @override
  WCPeerMeta get peerMeta;
  @override
  WCPeerMeta get remotePeerMeta;
  @override
  int get chainId;
  @override
  String get peerId;
  @override
  String get remotePeerId;
  @override
  @JsonKey(ignore: true)
  _$WCSessionStoreCopyWith<_WCSessionStore> get copyWith =>
      throw _privateConstructorUsedError;
}
