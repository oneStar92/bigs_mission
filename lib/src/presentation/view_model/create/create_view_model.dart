part of '../view_model.dart';

@riverpod
class CreateViewModel extends _$CreateViewModel {
  @override
  FutureOr<CreateState> build({required int id}) {
    return CreateState();
  }

  bool get canCreate =>
      (state.valueOrNull?.title.isNotEmpty ?? false) &&
      (state.valueOrNull?.content.isNotEmpty ?? false) &&
      (state.valueOrNull?.category.isNotEmpty ?? false);

  changeTitle(String title) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(title: title));
    }
  }

  changeContent(String content) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(content: content));
    }
  }

  changeCategory(String category) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(category: category));
    }
  }

  Future<void> create() async {
    final value = state.valueOrNull;

    if (value != null && !value.isLoading) {
      state = AsyncValue.data(value.copyWith(isLoading: true));

      state = await AsyncValue.guard(() async {
        await ref.watch(
          createBoardProvider.call(title: value.title, content: value.content, category: value.category).future,
        );

        return value.copyWith(isLoading: false);
      });
    }
  }
}
