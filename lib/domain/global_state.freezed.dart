// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'global_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
GlobalState _$GlobalStateFromJson(Map<String, dynamic> json) {
  return _GlobalState.fromJson(json);
}

class _$GlobalStateTearOff {
  const _$GlobalStateTearOff();

// ignore: unused_element
  _GlobalState call({@required @JsonKey(ignore: true) Color color}) {
    return _GlobalState(
      color: color,
    );
  }
}

// ignore: unused_element
const $GlobalState = _$GlobalStateTearOff();

mixin _$GlobalState {
  @JsonKey(ignore: true)
  Color get color;

  Map<String, dynamic> toJson();
  $GlobalStateCopyWith<GlobalState> get copyWith;
}

abstract class $GlobalStateCopyWith<$Res> {
  factory $GlobalStateCopyWith(
          GlobalState value, $Res Function(GlobalState) then) =
      _$GlobalStateCopyWithImpl<$Res>;
  $Res call({@JsonKey(ignore: true) Color color});
}

class _$GlobalStateCopyWithImpl<$Res> implements $GlobalStateCopyWith<$Res> {
  _$GlobalStateCopyWithImpl(this._value, this._then);

  final GlobalState _value;
  // ignore: unused_field
  final $Res Function(GlobalState) _then;

  @override
  $Res call({
    Object color = freezed,
  }) {
    return _then(_value.copyWith(
      color: color == freezed ? _value.color : color as Color,
    ));
  }
}

abstract class _$GlobalStateCopyWith<$Res>
    implements $GlobalStateCopyWith<$Res> {
  factory _$GlobalStateCopyWith(
          _GlobalState value, $Res Function(_GlobalState) then) =
      __$GlobalStateCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(ignore: true) Color color});
}

class __$GlobalStateCopyWithImpl<$Res> extends _$GlobalStateCopyWithImpl<$Res>
    implements _$GlobalStateCopyWith<$Res> {
  __$GlobalStateCopyWithImpl(
      _GlobalState _value, $Res Function(_GlobalState) _then)
      : super(_value, (v) => _then(v as _GlobalState));

  @override
  _GlobalState get _value => super._value as _GlobalState;

  @override
  $Res call({
    Object color = freezed,
  }) {
    return _then(_GlobalState(
      color: color == freezed ? _value.color : color as Color,
    ));
  }
}

@JsonSerializable()
class _$_GlobalState implements _GlobalState {
  const _$_GlobalState({@required @JsonKey(ignore: true) this.color})
      : assert(color != null);

  factory _$_GlobalState.fromJson(Map<String, dynamic> json) =>
      _$_$_GlobalStateFromJson(json);

  @override
  @JsonKey(ignore: true)
  final Color color;

  @override
  String toString() {
    return 'GlobalState(color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GlobalState &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(color);

  @override
  _$GlobalStateCopyWith<_GlobalState> get copyWith =>
      __$GlobalStateCopyWithImpl<_GlobalState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GlobalStateToJson(this);
  }
}

abstract class _GlobalState implements GlobalState {
  const factory _GlobalState({@required @JsonKey(ignore: true) Color color}) =
      _$_GlobalState;

  factory _GlobalState.fromJson(Map<String, dynamic> json) =
      _$_GlobalState.fromJson;

  @override
  @JsonKey(ignore: true)
  Color get color;
  @override
  _$GlobalStateCopyWith<_GlobalState> get copyWith;
}
