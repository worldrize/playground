// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'iap_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$IapStateTearOff {
  const _$IapStateTearOff();

// ignore: unused_element
  _IapState call({PurchaserInfo purchaserInfo, Offerings offerings}) {
    return _IapState(
      purchaserInfo: purchaserInfo,
      offerings: offerings,
    );
  }
}

// ignore: unused_element
const $IapState = _$IapStateTearOff();

mixin _$IapState {
  PurchaserInfo get purchaserInfo;
  Offerings get offerings;

  $IapStateCopyWith<IapState> get copyWith;
}

abstract class $IapStateCopyWith<$Res> {
  factory $IapStateCopyWith(IapState value, $Res Function(IapState) then) =
      _$IapStateCopyWithImpl<$Res>;
  $Res call({PurchaserInfo purchaserInfo, Offerings offerings});
}

class _$IapStateCopyWithImpl<$Res> implements $IapStateCopyWith<$Res> {
  _$IapStateCopyWithImpl(this._value, this._then);

  final IapState _value;
  // ignore: unused_field
  final $Res Function(IapState) _then;

  @override
  $Res call({
    Object purchaserInfo = freezed,
    Object offerings = freezed,
  }) {
    return _then(_value.copyWith(
      purchaserInfo: purchaserInfo == freezed
          ? _value.purchaserInfo
          : purchaserInfo as PurchaserInfo,
      offerings:
          offerings == freezed ? _value.offerings : offerings as Offerings,
    ));
  }
}

abstract class _$IapStateCopyWith<$Res> implements $IapStateCopyWith<$Res> {
  factory _$IapStateCopyWith(_IapState value, $Res Function(_IapState) then) =
      __$IapStateCopyWithImpl<$Res>;
  @override
  $Res call({PurchaserInfo purchaserInfo, Offerings offerings});
}

class __$IapStateCopyWithImpl<$Res> extends _$IapStateCopyWithImpl<$Res>
    implements _$IapStateCopyWith<$Res> {
  __$IapStateCopyWithImpl(_IapState _value, $Res Function(_IapState) _then)
      : super(_value, (v) => _then(v as _IapState));

  @override
  _IapState get _value => super._value as _IapState;

  @override
  $Res call({
    Object purchaserInfo = freezed,
    Object offerings = freezed,
  }) {
    return _then(_IapState(
      purchaserInfo: purchaserInfo == freezed
          ? _value.purchaserInfo
          : purchaserInfo as PurchaserInfo,
      offerings:
          offerings == freezed ? _value.offerings : offerings as Offerings,
    ));
  }
}

class _$_IapState implements _IapState {
  const _$_IapState({this.purchaserInfo, this.offerings});

  @override
  final PurchaserInfo purchaserInfo;
  @override
  final Offerings offerings;

  @override
  String toString() {
    return 'IapState(purchaserInfo: $purchaserInfo, offerings: $offerings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _IapState &&
            (identical(other.purchaserInfo, purchaserInfo) ||
                const DeepCollectionEquality()
                    .equals(other.purchaserInfo, purchaserInfo)) &&
            (identical(other.offerings, offerings) ||
                const DeepCollectionEquality()
                    .equals(other.offerings, offerings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(purchaserInfo) ^
      const DeepCollectionEquality().hash(offerings);

  @override
  _$IapStateCopyWith<_IapState> get copyWith =>
      __$IapStateCopyWithImpl<_IapState>(this, _$identity);
}

abstract class _IapState implements IapState {
  const factory _IapState({PurchaserInfo purchaserInfo, Offerings offerings}) =
      _$_IapState;

  @override
  PurchaserInfo get purchaserInfo;
  @override
  Offerings get offerings;
  @override
  _$IapStateCopyWith<_IapState> get copyWith;
}
