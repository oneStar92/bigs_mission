part of '../view_model.dart';

sealed class LoginException implements Exception {
  String get message;

  @override
  String toString() => message;
}

final class LoginFailedException implements LoginException {
  @override
  String get message => '로그인에 실패했어요.\n아이디 및 비밀번호를 확인해주세요.';

  LoginFailedException();
}
