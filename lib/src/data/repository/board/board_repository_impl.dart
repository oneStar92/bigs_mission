part of '../repository_impl.dart';

final class BoardRepositoryImpl implements BoardRepository {
  BoardRepositoryImpl({required BoardDataSource source}) : _source = source;

  final BoardDataSource _source;

  @override
  Future<void> createBoard({required String title, required String content, required String category}) =>
      _source.createBoard(title: title, content: content, category: category);

  @override
  Future<void> deleteBoard({required int id}) => _source.deleteBoard(id: id);

  @override
  Future<BoardEntity> fetchBoardDetail({required int id}) async {
    final boardDTO = await _source.fetchBoardDetail(id: id);
    return boardDTO.toEntity();
  }

  @override
  Future<BoardsPageEntity> fetchNextPage({required int pageNumber}) async {
    final pageDTO = await _source.fetchNextPage(pageNumber: pageNumber);
    return pageDTO.toEntity();
  }

  @override
  Future<BoardEntity> updateBoard({
    required BoardEntity board,
    required String title,
    required String content,
    required String category,
  }) async {
    await _source.updateBoard(id: board.id, title: title, content: content, category: category);
    return board.copyWith(title: title, content: content, category: category);
  }
}

@riverpod
BoardRepository boardRepository(Ref ref) {
  final source = ref.watch(boardDataSourceProvider);
  return BoardRepositoryImpl(source: source);
}
