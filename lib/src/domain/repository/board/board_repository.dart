part of '../repository.dart';

abstract class BoardRepository {
  Future<BoardsPageEntity> fetchNextPage({required int pageNumber});

  Future<BoardEntity> fetchBoardDetail({required int id});

  Future<int> createBoard({required String title, required String content, required Category category});

  Future<BoardEntity> updateBoard({
    required BoardEntity board,
    required String title,
    required String content,
    required Category category,
  });

  Future<void> deleteBoard({required int id});
}
