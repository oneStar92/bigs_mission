part of '../mapper.dart';

extension BoardItemEntityMapper on BoardItemDTO {
  BoardItemEntity toEntity() {
    return BoardItemEntity(id: id, title: title, category: Category.fromJson(category), createdAt: createdAt);
  }
}

extension BoardsPageEntityMapper on BoardsPageDTO {
  BoardsPageEntity toEntity() {
    return BoardsPageEntity(
      boards: content.map((dto) => dto.toEntity()).toList(),
      hasNext: !last,
      number: number,
      isEmpty: empty,
    );
  }
}
