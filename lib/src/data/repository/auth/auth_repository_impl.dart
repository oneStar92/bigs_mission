part of '../repository_impl.dart';

final class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthDataSource source}) : _source = source;

  final AuthDataSource _source;

  @override
  Future<TokenEntity> login({required String id, required String password}) async {
    final tokenDTO = await _source.login(id: id, password: password);
    return tokenDTO.toEntity();
  }

  @override
  Future<TokenEntity> refresh({required String refreshToken}) async {
    final tokenDTO = await _source.refresh(refreshToken: refreshToken);
    return tokenDTO.toEntity();
  }

  @override
  Future<void> signup({
    required String id,
    required String name,
    required String password,
    required String confirmPassword,
  }) async {
    await _source.signup(id: id, name: name, password: password, confirmPassword: confirmPassword);
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final source = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(source: source);
}