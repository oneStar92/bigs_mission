part of '../entity.dart';

@Freezed(fromJson: false, toJson: false)
abstract class BoardItem with _$BoardItem {
  const factory BoardItem({
    required int id,
    required String title,
    required String category,
    required String createdAt,
  }) = _BoardItem;
}

@Freezed(fromJson: false, toJson: false)
abstract class BoardPage with _$BoardPage {
  const factory BoardPage({
    required List<BoardItem> boards,
    required bool hasNext,
    required int number,
    required bool isEmpty,
  }) = _BoardPage;

  factory BoardPage.firstPage() =>
      _BoardPage(boards: List.empty(growable: true), hasNext: true, number: 0, isEmpty: false);
}
