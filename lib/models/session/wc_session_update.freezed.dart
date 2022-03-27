// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wc_session_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WCSessionUpdate _$WCSessionUpdateFromJson(Map<String, dynamic> json) {
  return _WCSessionUpdate.fromJson(json);
}

/// @nodoc
class _$WCSessionUpdateTearOff {
  const _$WCSessionUpdateTearOff();

  _WCSessionUpdate call(
      {required bool approved, int? chainId, List<String>? accounts}) {
    return _WCSessionUpdate(
      approved: approved,
      chainId: chainId,
      accounts: accounts,
    );
  }

  WCSessionUpdate fromJson(Map<String, Object?> json) {
    return WCSessionUpdate.fromJson(json);
  }
}

/// @nodoc
const $WCSessionUpdate = _$WCSessionUpdateTearOff();

/// @nodoc
mixin _$WCSessionUpdate {
  bool get approved => throw _privateConstructorUsedError;
  int? get chainId => throw _privateConstructorUsedError;
  List<String>? get accounts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WCSessionUpdateCopyWith<WCSessionUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WCSessionUpdateCopyWith<$Res> {
  factory $WCSessionUpdateCopyWith(
          WCSessionUpdate value, $Res Function(WCSessionUpdate) then) =
      _$WCSessionUpdateCopyWithImpl<$Res>;
  $Res call({bool approved, int? chainId, List<String>? accounts});
}

/// @nodoc
class _$WCSessionUpdateCopyWithImpl<$Res>
    implements $WCSessionUpdateCopyWith<$Res> {
  _$WCSessionUpdateCopyWithImpl(this._value, this._then);

  final WCSessionUpdate _value;
  // ignore: unused_field
  final $Res Function(WCSessionUpdate) _then;

  @override
  $Res call({
    Object? approved = freezed,
    Object? chainId = freezed,
    Object? accounts = freezed,
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
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$WCSessionUpdateCopyWith<$Res>
    implements $WCSessionUpdateCopyWith<$Res> {
  factory _$WCSessionUpdateCopyWith(
          _WCSessionUpdate value, $Res Function(_WCSessionUpdate) then) =
      __$WCSessionUpdateCopyWithImpl<$Res>;
  @override
  $Res call({bool approved, int? chainId, List<String>? accounts});
}

/// @nodoc
class __$WCSessionUpdateCopyWithImpl<$Res>
    extends _$WCSessionUpdateCopyWithImpl<$Res>
    implements _$WCSessionUpdateCopyWith<$Res> {
  __$WCSessionUpdateCopyWithImpl(
      _WCSessionUpdate _value, $Res Function(_WCSessionUpdate) _then)
      : super(_value, (v) => _then(v as _WCSessionUpdate));

  @override
  _WCSessionUpdate get _value => super._value as _WCSessionUpdate;

  @override
  $Res call({
    Object? approved = freezed,
    Object? chainId = freezed,
    Object? accounts = freezed,
  }) {
    return _then(_WCSessionUpdate(
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
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WCSessionUpdate implements _WCSessionUpdate {
  _$_WCSessionUpdate({required this.approved, this.chainId, this.accounts});

  factory _$_WCSessionUpdate.fromJson(Map<String, dynamic> json) =>
      _$$_WCSessionUpdateFromJson(json);

  @override
  final bool approved;
  @override
  final int? chainId;
  @override
  final List<String>? accounts;

  @override
  String toString() {
    return 'WCSessionUpdate(approved: $approved, chainId: $chainId, accounts: $accounts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WCSessionUpdate &&
            const DeepCollectionEquality().equals(other.approved, approved) &&
            const DeepCollectionEquality().equals(other.chainId, chainId) &&
            const DeepCollectionEquality().equals(other.accounts, accounts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(approved),
      const DeepCollectionEquality().hash(chainId),
      const DeepCollectionEquality().hash(accounts));

  @JsonKey(ignore: true)
  @override
  _$WCSessionUpdateCopyWith<_WCSessionUpdate> get copyWith =>
      __$WCSessionUpdateCopyWithImpl<_WCSessionUpdate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WCSessionUpdateToJson(this);
  }
}

abstract class _WCSessionUpdate implements WCSessionUpdate {
  factory _WCSessionUpdate(
      {required bool approved,
      int? chainId,
      List<String>? accounts}) = _$_WCSessionUpdate;

  factory _WCSessionUpdate.fromJson(Map<String, dynamic> json) =
      _$_WCSessionUpdate.fromJson;

  @override
  bool get approved;
  @override
  int? get chainId;
  @override
  List<String>? get accounts;
  @override
  @JsonKey(ignore: true)
  _$WCSessionUpdateCopyWith<_WCSessionUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}
