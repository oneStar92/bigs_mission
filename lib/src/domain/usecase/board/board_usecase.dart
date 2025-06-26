part of '../usecase.dart';

@riverpod
Future<BoardsPageEntity> fetchInitialPage(Ref ref) async {
  final repository = ref.watch(boardRepositoryProvider);
  return await repository.fetchNextPage(pageNumber: 0);
}

@riverpod
Future<BoardsPageEntity> fetchNextPage(Ref ref, {required int pageNumber}) async {
  final repository = ref.watch(boardRepositoryProvider);
  return await repository.fetchNextPage(pageNumber: pageNumber);
}

@riverpod
Future<BoardEntity> fetchBoardDetail(Ref ref, {required int id}) async {
  final repository = ref.watch(boardRepositoryProvider);
  return await repository.fetchBoardDetail(id: id);
}

@riverpod
Future<BoardItemEntity> createBoard(
  Ref ref, {
  required String title,
  required String content,
  required Category category,
}) async {
  try {
    final repository = ref.watch(boardRepositoryProvider);
    final id = await repository.createBoard(title: title, content: content, category: category);
    return BoardItemEntity(id: id, title: title, category: category, createdAt: DateTime.now().toIso8601String());
  } catch (e) {
    rethrow;
  }
}

@riverpod
Future<BoardEntity> updateBoard(
  Ref ref, {
  required BoardEntity board,
  required String title,
  required String content,
  required Category category,
}) async {
  final repository = ref.watch(boardRepositoryProvider);
  return await repository.updateBoard(board: board, title: title, content: content, category: category);
}

@riverpod
Future<void> deleteBoard(Ref ref, {required int id}) async {
  final repository = ref.watch(boardRepositoryProvider);
  return await repository.deleteBoard(id: id);
}
