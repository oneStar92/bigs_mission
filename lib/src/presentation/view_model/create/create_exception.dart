part of '../view_model.dart';

sealed class CreateException implements Exception {
  String get message;

  @override
  String toString() => message;
}

final class CreateFailedException implements CreateException {
  @override
  String get message => '게시글 작성에 실패했어요.';

  CreateFailedException();
}

final class CreateMissingFieldException implements CreateException {
  @override
  String get message => '필수 입력값을 모두 입력해주세요.';

  CreateMissingFieldException();
}
