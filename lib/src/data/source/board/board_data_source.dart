part of '../source.dart';

abstract class BoardDataSource {
  Future<BoardsPageDTO> fetchNextPage({required int pageNumber});

  Future<BoardDTO> fetchBoardDetail({required int id});

  Future<int> createBoard({required String title, required String content, required Category category});

  Future<void> updateBoard({
    required int id,
    required String title,
    required String content,
    required Category category,
  });

  Future<void> deleteBoard({required int id});
}

class BoardDataSourceImpl implements BoardDataSource {
  BoardDataSourceImpl({required BoardService service}) : _service = service;

  final BoardService _service;

  @override
  Future<int> createBoard({required String title, required String content, required Category category}) {
    return _service.createBoard(requestJson: {'title': title, 'content': content, 'category': category.toJson()});
  }

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
    required Category category,
  }) => _service.updateBoard(id: id, requestJson: {'title': title, 'content': content, 'category': category.toJson()});
}

@riverpod
BoardDataSource boardDataSource(Ref ref) {
  return BoardDataSourceImpl(service: BoardServiceImpl());
}
