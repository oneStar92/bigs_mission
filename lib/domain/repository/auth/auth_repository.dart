part of '../repository.dart';

abstract class AuthRepository {
  Future<void> signup({
    required String id,
    required String name,
    required String password,
    required String confirmPassword,
  });

  Future<TokenEntity> login({required String id, required String password});

  Future<TokenEntity> refresh({required String refreshToken});
}
