// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'wc_peer_meta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WCPeerMeta _$WCPeerMetaFromJson(Map<String, dynamic> json) {
  return _WCPeerMeta.fromJson(json);
}

/// @nodoc
class _$WCPeerMetaTearOff {
  const _$WCPeerMetaTearOff();

  _WCPeerMeta call(
      {required String name,
      required String url,
      required String description,
      List<String> icons = const []}) {
    return _WCPeerMeta(
      name: name,
      url: url,
      description: description,
      icons: icons,
    );
  }

  WCPeerMeta fromJson(Map<String, Object?> json) {
    return WCPeerMeta.fromJson(json);
  }
}

/// @nodoc
const $WCPeerMeta = _$WCPeerMetaTearOff();

/// @nodoc
mixin _$WCPeerMeta {
  String get name => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get icons => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WCPeerMetaCopyWith<WCPeerMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WCPeerMetaCopyWith<$Res> {
  factory $WCPeerMetaCopyWith(
          WCPeerMeta value, $Res Function(WCPeerMeta) then) =
      _$WCPeerMetaCopyWithImpl<$Res>;
  $Res call({String name, String url, String description, List<String> icons});
}

/// @nodoc
class _$WCPeerMetaCopyWithImpl<$Res> implements $WCPeerMetaCopyWith<$Res> {
  _$WCPeerMetaCopyWithImpl(this._value, this._then);

  final WCPeerMeta _value;
  // ignore: unused_field
  final $Res Function(WCPeerMeta) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
    Object? description = freezed,
    Object? icons = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icons: icons == freezed
          ? _value.icons
          : icons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$WCPeerMetaCopyWith<$Res> implements $WCPeerMetaCopyWith<$Res> {
  factory _$WCPeerMetaCopyWith(
          _WCPeerMeta value, $Res Function(_WCPeerMeta) then) =
      __$WCPeerMetaCopyWithImpl<$Res>;
  @override
  $Res call({String name, String url, String description, List<String> icons});
}

/// @nodoc
class __$WCPeerMetaCopyWithImpl<$Res> extends _$WCPeerMetaCopyWithImpl<$Res>
    implements _$WCPeerMetaCopyWith<$Res> {
  __$WCPeerMetaCopyWithImpl(
      _WCPeerMeta _value, $Res Function(_WCPeerMeta) _then)
      : super(_value, (v) => _then(v as _WCPeerMeta));

  @override
  _WCPeerMeta get _value => super._value as _WCPeerMeta;

  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
    Object? description = freezed,
    Object? icons = freezed,
  }) {
    return _then(_WCPeerMeta(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icons: icons == freezed
          ? _value.icons
          : icons // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WCPeerMeta implements _WCPeerMeta {
  _$_WCPeerMeta(
      {required this.name,
      required this.url,
      required this.description,
      this.icons = const []});

  factory _$_WCPeerMeta.fromJson(Map<String, dynamic> json) =>
      _$$_WCPeerMetaFromJson(json);

  @override
  final String name;
  @override
  final String url;
  @override
  final String description;
  @JsonKey()
  @override
  final List<String> icons;

  @override
  String toString() {
    return 'WCPeerMeta(name: $name, url: $url, description: $description, icons: $icons)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WCPeerMeta &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.icons, icons));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(icons));

  @JsonKey(ignore: true)
  @override
  _$WCPeerMetaCopyWith<_WCPeerMeta> get copyWith =>
      __$WCPeerMetaCopyWithImpl<_WCPeerMeta>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WCPeerMetaToJson(this);
  }
}

abstract class _WCPeerMeta implements WCPeerMeta {
  factory _WCPeerMeta(
      {required String name,
      required String url,
      required String description,
      List<String> icons}) = _$_WCPeerMeta;

  factory _WCPeerMeta.fromJson(Map<String, dynamic> json) =
      _$_WCPeerMeta.fromJson;

  @override
  String get name;
  @override
  String get url;
  @override
  String get description;
  @override
  List<String> get icons;
  @override
  @JsonKey(ignore: true)
  _$WCPeerMetaCopyWith<_WCPeerMeta> get copyWith =>
      throw _privateConstructorUsedError;
}
