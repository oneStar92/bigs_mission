part of '../view_model.dart';

@riverpod
class SignupViewModel extends _$SignupViewModel {
  @override
  FutureOr<SignupState> build({required int id}) async {
    return SignupState();
  }

  changeId(String id) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(id: id));
    }
  }

  changeNickname(String nickname) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(nickname: nickname));
    }
  }

  changePassword(String password) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(password: password));
    }
  }

  changeConfirmPassword(String confirmPassword) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(confirmPassword: confirmPassword));
    }
  }

  Future<void> signup() async {
    final value = state.valueOrNull;

    if (value != null && !value.isLoading) {
      state = AsyncValue.data(value.copyWith(isLoading: true));

      state = await AsyncValue.guard(() async {
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

        return value.copyWith(isLoading: false);
      });
    }
  }
}
