part of '../view_model.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  FutureOr<LoginState> build({required int id}) async {
    return LoginState();
  }

  changeId(String id) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(id: id));
    }
  }

  changePassword(String password) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(password: password));
    }
  }

  Future<void> login() async {
    final value = state.valueOrNull;

    if (value != null && !value.isLoading) {
      state = AsyncValue.data(value.copyWith(isLoading: true));

      state = await AsyncValue.guard(() async {
        await ref.watch(loginProvider.call(id: value.id, password: value.password).future);

        return value.copyWith(isLoading: false);
      });
    }
  }
}
