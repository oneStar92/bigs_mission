part of '../entity.dart';

@Freezed(fromJson: false, toJson: false)
abstract class BoardEntity with _$BoardEntity {
  factory BoardEntity({
    required int id,
    required String title,
    required String content,
    required String category,
    required String createdAt,
    String? imageUrl,
  }) = _BoardEntity;
}
