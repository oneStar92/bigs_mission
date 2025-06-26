part of '../source.dart';

abstract class BoardService {
  Future<int> createBoard({required Map<String, dynamic> requestJson, String? filePath});

  Future<void> updateBoard({required int id, required Map<String, dynamic> requestJson, String? filePath});

  Future<void> deleteBoard({required int id});

  Future<BoardDTO> fetchBoard({required int id});

  Future<BoardsPageDTO> fetchBoards({required int pageNumber, required int size});
}

final class BoardServiceImpl implements BoardService {
  final Dio _dio = DioClient.instance.dio;

  @override
  Future<int> createBoard({required Map<String, dynamic> requestJson, String? filePath}) async {
    final formData = FormData();

    formData.files.add(
      MapEntry(
        'request',
        MultipartFile.fromString(
          jsonEncode(requestJson),
          contentType: DioMediaType('application', 'json'), // application/json
        ),
      ),
    );

    if (filePath != null) {
      final multipartFile = await MultipartFile.fromFile(
        filePath,
        filename: _generateRandomFilename(filePath),
        contentType: _getMediaTypeFromFilePath(filePath), // application/json
      );
      formData.files.add(MapEntry('file', multipartFile));
    }

    try {
      final resp = await _dio.post('boards', data: formData);
      return resp.data['id'] as int;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateBoard({required int id, required Map<String, dynamic> requestJson, String? filePath}) async {
    final formData = FormData();

    formData.files.add(
      MapEntry(
        'request',
        MultipartFile.fromString(
          jsonEncode(requestJson),
          contentType: DioMediaType('application', 'json'), // application/json
        ),
      ),
    );

    if (filePath != null) {
      final multipartFile = await MultipartFile.fromFile(
        filePath,
        filename: _generateRandomFilename(filePath),
        contentType: _getMediaTypeFromFilePath(filePath), // application/json
      );
      formData.files.add(MapEntry('file', multipartFile));
    }

    try {
      await _dio.patch('boards/$id', data: formData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteBoard({required int id}) async {
    try {
      await _dio.delete('boards/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BoardDTO> fetchBoard({required int id}) async {
    try {
      final result = await _dio.get<Map<String, dynamic>>('boards/$id');
      return BoardDTO.fromJson(result.data!);
    } on Object catch (e, s) {
      rethrow;
    }
  }

  @override
  Future<BoardsPageDTO> fetchBoards({required int pageNumber, required int size}) async {
    final queryParameters = <String, dynamic>{r'page': pageNumber, r'size': size};
    try {
      final result = await _dio.get<Map<String, dynamic>>('boards', queryParameters: queryParameters);
      return BoardsPageDTO.fromJson(result.data!);
    } on Object catch (e, s) {
      rethrow;
    }
  }

  DioMediaType _getMediaTypeFromFilePath(String filePath) {
    final extension = p.extension(filePath).toLowerCase();

    switch (extension) {
      case '.png':
        return DioMediaType('image', 'png');
      case '.jpg':
      case '.jpeg':
        return DioMediaType('image', 'jpeg');
      case '.gif':
        return DioMediaType('image', 'gif');
      default:
        return DioMediaType('application', 'octet-stream');
    }
  }

  String _generateRandomFilename(String filePath) {
    final extension = p.extension(filePath); // .jpg, .png 등
    final uuid = const Uuid().v4(); // 고유한 ID 생성
    return '$uuid$extension';
  }
}
