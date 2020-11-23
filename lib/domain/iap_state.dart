import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/object_wrappers.dart';

part 'iap_state.freezed.dart';

@freezed
abstract class IapState with _$IapState {
  const factory IapState({
    PurchaserInfo purchaserInfo,
    Offerings offerings,
  }) = _IapState;
}
