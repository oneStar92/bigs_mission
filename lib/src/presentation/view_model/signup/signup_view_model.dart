part of '../view_model.dart';

@Riverpod(keepAlive: false)
class SignupViewModel extends _$SignupViewModel {
  @override
  FutureOr<SignupState> build() async {
    return SignupState();
  }

  onChangeId(String id) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(id: id));
    }
  }

  onChangeNickname(String nickname) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(nickname: nickname));
    }
  }

  onChangePassword(String password) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(password: password));
    }
  }

  onChangeConfirmPassword(String confirmPassword) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(confirmPassword: confirmPassword));
    }
  }

  onFocusId() {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(validateId: true));
    }
  }

  onFocusNickname() {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(validateNickname: true));
    }
  }

  onFocusPassword() {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(validatePassword: true));
    }
  }

  onFocusConfirmPassword() {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(validateConfirmPassword: true));
    }
  }

  validateAll() {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(
        value.copyWith(validateId: true, validateNickname: true, validatePassword: true, validateConfirmPassword: true),
      );
    }
  }

  Future<void> signup() async {
    final value = state.valueOrNull;

    if (value != null && !value.isLoading) {
      state = AsyncValue.data(value.copyWith(isLoading: true));

      try {
        await ref.watch(
          signupProvider
              .call(
                id: value.id,
                nickname: value.nickname,
                password: value.password,
                confirmPassword: value.confirmPassword,
              )
              .future,
        );
      } catch (e) {
        throw SignupFailedException();
      } finally {
        state = AsyncValue.data(value.copyWith(isLoading: false));
      }
    }
  }
}
