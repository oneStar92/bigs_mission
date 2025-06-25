part of '../view_model.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  FutureOr<LoginState> build() async {
    return LoginState();
  }

  onChangeId(String id) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(id: id));
    }
  }

  onChangePassword(String password) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(password: password));
    }
  }

  Future<void> login() async {
    final value = state.valueOrNull;

    if (value != null && !value.isLoading) {
      state = AsyncValue.data(value.copyWith(isLoading: true));

      try {
        final tokenEntity = await ref.watch(loginProvider.call(id: value.id, password: value.password).future);
        print(tokenEntity);
        await TokenStorage.instance.saveToken(tokenEntity);
      } catch (e) {
        throw LoginFailedException();
      } finally {
        state = AsyncValue.data(value.copyWith(isLoading: false));
      }
    }
  }

  Future<void> reset() async {
    state = AsyncValue.data(LoginState());
  }
}
