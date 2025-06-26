part of '../view_model.dart';

sealed class UpdateException implements Exception {
  String get message;

  @override
  String toString() => message;
}

final class UpdateFailedException implements UpdateException {
  @override
  String get message => '게시글 수정에 실패했어요.';

  UpdateFailedException();
}

final class UpdateMissingFieldException implements UpdateException {
  @override
  String get message => '필수 입력값을 모두 입력해주세요.';

  UpdateMissingFieldException();
}
