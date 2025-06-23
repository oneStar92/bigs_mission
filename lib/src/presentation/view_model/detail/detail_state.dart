part of '../view_model.dart';

@freezed
abstract class DetailState with _$DetailState {
  const factory DetailState({required BoardEntity board}) = _DetailState;
}
