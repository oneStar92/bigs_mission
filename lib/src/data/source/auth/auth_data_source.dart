part of '../source.dart';

abstract class AuthDataSource {
  Future<void> signup({
    required String id,
    required String name,
    required String password,
    required String confirmPassword,
  });

  Future<TokenDTO> login({required String id, required String password});

  Future<TokenDTO> refresh({required String refreshToken});
}

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl({required AuthService service}) : _service = service;

  final AuthService _service;

  @override
  Future<TokenDTO> login({required String id, required String password}) =>
      _service.login(body: {'username': id, 'password': password});

  @override
  Future<TokenDTO> refresh({required String refreshToken}) => _service.refresh(body: {'refreshToken': refreshToken});

  @override
  Future<void> signup({
    required String id,
    required String name,
    required String password,
    required String confirmPassword,
  }) => _service.signup(body: {'username': id, 'name': name, 'password': password, 'confirmPassword': confirmPassword});
}

@riverpod
AuthDataSource authDataSource(Ref ref) {
  return AuthDataSourceImpl(service: AuthService(DioClient.instance.dio));
}
