part of '../view_model.dart';

class SignupValidator {
  static String? validateId(String id) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (id.isEmpty) return '이메일을 입력해주세요.';
    if (!emailRegex.hasMatch(id)) return '올바른 이메일 형식이 아닙니다.';
    return null;
  }

  static String? validateNickname(String nickname) {
    if (nickname.isEmpty) return '닉네임을 입력해주세요.';
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) return '비밀번호를 입력해주세요.';
    if (password.length < 8) return '비밀번호는 8자 이상이어야 합니다.';
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!%*#?&])[A-Za-z\d!%*#?&]{8,}$');
    if (!regex.hasMatch(password)) return '영문, 숫자, 특수문자를 포함해야 합니다.';
    return null;
  }

  static String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return '비밀번호 확인을 입력해주세요.';
    if (password != confirmPassword) return '비밀번호가 일치하지 않습니다.';
    if (validatePassword(password) != null) return '올바른 비밀번호를 입력해주세요.';
    return null;
  }
}

@riverpod
String? idError(Ref ref) {
  final state = ref.watch(signupViewModelProvider).valueOrNull;
  if (state == null || !state.validateId) return null;
  return SignupValidator.validateId(state.id);
}

@riverpod
String? nicknameError(Ref ref) {
  final state = ref.watch(signupViewModelProvider).valueOrNull;
  if (state == null || !state.validateNickname) return null;
  return SignupValidator.validateNickname(state.nickname);
}

@riverpod
String? passwordError(Ref ref) {
  final state = ref.watch(signupViewModelProvider).valueOrNull;
  if (state == null || !state.validatePassword) return null;
  return SignupValidator.validatePassword(state.password);
}

@riverpod
String? confirmPasswordError(Ref ref) {
  final state = ref.watch(signupViewModelProvider).valueOrNull;
  if (state == null || !state.validateConfirmPassword) return null;
  return SignupValidator.validateConfirmPassword(state.password, state.confirmPassword);
}

@riverpod
bool isSignupFormValid(Ref ref) {
  final state = ref.watch(signupViewModelProvider).valueOrNull;

  if (state == null) return false;

  final id = state.id;
  final nickname = state.nickname;
  final password = state.password;
  final confirmPassword = state.confirmPassword;

  if (id.isEmpty || nickname.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
    return false;
  }

  final isIdValid = SignupValidator.validateId(state.id) == null;
  final isNicknameValid = SignupValidator.validateNickname(state.nickname) == null;
  final isPasswordValid = SignupValidator.validatePassword(state.password) == null;
  final isConfirmPasswordValid = SignupValidator.validateConfirmPassword(state.password, state.confirmPassword) == null;

  return isIdValid && isNicknameValid && isPasswordValid && isConfirmPasswordValid;
}
