part of '../view_model.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    @Default('') String id,
    @Default('') String password,
    @Default(null) String? errorMessage,
  }) = _LoginState;
}
