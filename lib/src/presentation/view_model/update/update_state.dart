part of '../view_model.dart';

@freezed
abstract class UpdateState with _$UpdateState {
  const factory UpdateState({
    @Default(false) bool isLoading,
    required BoardEntity previous,
    @Default('') String title,
    @Default('') String content,
    @Default(null) Category? category,
  }) = _UpdateState;
}
