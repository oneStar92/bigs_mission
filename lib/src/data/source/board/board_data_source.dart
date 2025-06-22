part of '../source.dart';

abstract class BoardDataSource {
  Future<BoardsPageDTO> fetchNextPage({required int pageNumber});

  Future<BoardDTO> fetchBoardDetail({required int id});

  Future<void> createBoard({required String title, required String content, required String category});

  Future<void> updateBoard({required int id, required String title, required String content, required String category});

  Future<void> deleteBoard({required int id});
}

class BoardDataSourceImpl implements BoardDataSource {
  BoardDataSourceImpl({required BoardService service}) : _service = service;

  final BoardService _service;

  @override
  Future<void> createBoard({required String title, required String content, required String category}) =>
      _service.createBoard(body: {'title': title, 'content': content, 'category': category});

  @override
  Future<void> deleteBoard({required int id}) => _service.deleteBoard(id: id);

  @override
  Future<BoardDTO> fetchBoardDetail({required int id}) => _service.fetchBoard(id: id);

  @override
  Future<BoardsPageDTO> fetchNextPage({required int pageNumber}) =>
      _service.fetchBoards(pageNumber: pageNumber, size: 20);

  @override
  Future<void> updateBoard({
    required int id,
    required String title,
    required String content,
    required String category,
  }) => _service.updateBoard(id: id, body: {'title': title, 'content': content, 'category': category});
}

@riverpod
BoardDataSource boardDataSource(Ref ref) {
  final http = ref.watch(httpProvider);
  return BoardDataSourceImpl(service: BoardService(http));
}