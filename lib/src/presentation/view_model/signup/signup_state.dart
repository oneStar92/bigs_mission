part of '../view_model.dart';

@freezed
abstract class SignupState with _$SignupState {
  const factory SignupState({
    @Default(false) bool isLoading,
    @Default('') String id,
    @Default('') String nickname,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default(false) bool validateId,
    @Default(false) bool validateNickname,
    @Default(false) bool validatePassword,
    @Default(false) bool validateConfirmPassword,
  }) = _SignupState;
}