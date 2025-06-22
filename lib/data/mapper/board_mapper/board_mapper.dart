part of '../mapper.dart';

extension BoardEntityMapper on BoardDTO {
  BoardEntity toEntity() {
    return BoardEntity(id: id, title: title, content: content, category: category, createdAt: createdAt);
  }
}
