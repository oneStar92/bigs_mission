part of '../view_model.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<BoardItemEntity> boards,
    @Default(0) int currentPageNumber,
    @Default(true) bool hasNext,
    @Default(false) bool isEmpty,
  }) = _HomeState;
}
