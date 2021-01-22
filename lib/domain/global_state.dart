import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_state.freezed.dart';
part 'global_state.g.dart';

@freezed
abstract class GlobalState with _$GlobalState {
  const factory GlobalState({
    @JsonKey(ignore: true) @required Color color,
  }) = _GlobalState;

  factory GlobalState.fromJson(Map<String, dynamic> json) =>
      _$GlobalStateFromJson(json);
}
