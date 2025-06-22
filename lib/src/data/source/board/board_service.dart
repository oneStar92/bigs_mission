part of '../source.dart';

@RestApi()
abstract class BoardService {
  factory BoardService(Dio dio, {String baseUrl}) = _BoardService;

  @POST('boards')
  Future<void> createBoard({@Body() required Map<String, dynamic> body});

  @PATCH('boards/{id}')
  Future<void> updateBoard({@Path('id') required int id, @Body() required Map<String, dynamic> body});

  @DELETE('boards/{id}')
  Future<void> deleteBoard({@Path('id') required int id});

  @GET('boards/{id}')
  Future<BoardDTO> fetchBoard({@Path('id') required int id});

  @GET('boards')
  Future<BoardsPageDTO> fetchBoards({@Query('page') required int pageNumber, @Query('size') required int size});
}
