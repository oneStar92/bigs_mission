part of '../entity.dart';

@Freezed(fromJson: false, toJson: false)
abstract class BoardItemEntity with _$BoardItemEntity {
  const factory BoardItemEntity({
    required int id,
    required String title,
    required Category category,
    required String createdAt,
  }) = _BoardItemEntity;
}

@Freezed(fromJson: false, toJson: false)
abstract class BoardsPageEntity with _$BoardsPageEntity {
  const factory BoardsPageEntity({
    required List<BoardItemEntity> boards,
    required bool hasNext,
    required int number,
    required bool isEmpty,
  }) = _BoardsPageEntity;

  factory BoardsPageEntity.firstPage() =>
      _BoardsPageEntity(boards: List.empty(growable: true), hasNext: true, number: 0, isEmpty: false);
}
