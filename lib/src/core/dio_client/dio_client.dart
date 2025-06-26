part of '../core.dart';

class DioClient {
  late final Dio dio;

  DioClient._();

  static final DioClient _instance = DioClient._();

  static DioClient get instance => _instance;

  factory DioClient() => instance;

  initial() {
    dio = Dio(BaseOptions(baseUrl: 'https://front-mission.bigs.or.kr/', headers: {'Accept': '*/*'}));
    dio.interceptors.add(ApiInterceptor());
  }
}

final class ApiInterceptor extends Interceptor {
  ApiInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final excludedPaths = ['login', 'signup', 'refresh'];

    if (!excludedPaths.any((path) => options.path.contains(path))) {
      final accessToken = TokenStorage.instance.accessToken;
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.reject(err);
    }

    final newTokenAvailable = await _refresh().onError((_, __) => false);

    if (newTokenAvailable) {
      _retryRequest(err.requestOptions, TokenStorage.instance.accessToken ?? '', handler);
    } else {
      TokenStorage.instance.deleteToken();
      return handler.reject(err);
    }
  }

  Future<bool> _refresh() async {
    try {
      final refreshToken = TokenStorage.instance.refreshToken;
      if (refreshToken == null) return false;

      final refreshDio = Dio(
        BaseOptions(
          baseUrl: 'https://front-mission.bigs.or.kr/',
          headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
        ),
      );
      final resp = await refreshDio.post('auth/refresh', data: {'refreshToken': refreshToken});

      final newAccessToken = resp.data['accessToken'];
      final newRefreshToken = resp.data['refreshToken'];

      await TokenStorage.instance.saveToken(TokenEntity(accessToken: newAccessToken, refreshToken: newRefreshToken));

      return true;
    } on DioException catch (e) {
      return false;
    }
  }

  void _retryRequest(RequestOptions options, String accessToken, ErrorInterceptorHandler handler) async {
    final dio = Dio();
    final currentOptions = options;
    currentOptions.headers['Authorization'] = 'Bearer $accessToken';
    try {
      final response = await dio.fetch(currentOptions);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.reject(e);
    }
  }
}
