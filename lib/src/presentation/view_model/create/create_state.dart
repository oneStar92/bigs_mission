part of '../view_model.dart';

@freezed
abstract class CreateState with _$CreateState {
  const factory CreateState({
    @Default(false) bool isLoading,
    @Default('') String title,
    @Default('') String content,
    @Default(null) Category? category,
    @Default(false) bool validateTitle,
    @Default(false) bool validateContent,
    @Default(false) bool validateCategory,
  }) = _CreateState;
}
