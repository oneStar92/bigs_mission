part of '../view_model.dart';

sealed class SignupException implements Exception {
  String get message;

  @override
  String toString() => message;
}

final class SignupFailedException implements SignupException {
  @override
  String get message => '회원가입에 실패했어요.';

  SignupFailedException();
}

final class SignupMissingFieldException implements SignupException {
  @override
  String get message => '필수 입력값을 모두 입력해주세요.';

  SignupMissingFieldException();
}
