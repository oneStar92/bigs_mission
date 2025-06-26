part of '../view_model.dart';

@freezed
abstract class DetailState with _$DetailState {
  const factory DetailState({@Default(false) bool isLoading, required BoardEntity board}) = _DetailState;
}
