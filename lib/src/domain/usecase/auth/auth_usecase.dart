part of '../usecase.dart';

@riverpod
Future<void> signup(
  Ref ref, {
  required String id,
  required String nickname,
  required String password,
  required String confirmPassword,
}) async {
  final repository = ref.watch(authRepositoryProvider);
  return await repository.signup(id: id, name: nickname, password: password, confirmPassword: confirmPassword);
}

@riverpod
Future<TokenEntity> login(Ref ref, {required String id, required String password}) async {
  final repository = ref.watch(authRepositoryProvider);
  return await repository.login(id: id, password: password);
}

@riverpod
Future<TokenEntity> refresh(Ref ref, {required String refreshToken}) async {
  final repository = ref.watch(authRepositoryProvider);
  return await repository.refresh(refreshToken: refreshToken);
}
