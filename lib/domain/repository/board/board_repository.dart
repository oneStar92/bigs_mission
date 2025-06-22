part of '../repository.dart';

abstract class BoardRepository {
  Future<BoardsPageEntity> fetchNextPage({required int pageNumber});

  Future<BoardEntity> fetchBoardDetail({required int id});

  Future<void> createBoard({required String title, required String content, required String category});

  Future<void> updateBoard({required BoardEntity board});

  Future<void> deleteBoard({required int id});
}
