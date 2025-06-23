part of '../view_model.dart';

@riverpod
class UpdateViewModel extends _$UpdateViewModel {
  @override
  FutureOr<UpdateState> build({required BoardEntity previous}) async {
    return UpdateState(
      previous: previous,
      title: previous.title,
      content: previous.content,
      category: previous.category,
    );
  }

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

  Future<void> updateBoard() async {
    final value = state.valueOrNull;

    if (value != null && !value.isLoading) {
      state = AsyncValue.data(value.copyWith(isLoading: true));

      state = await AsyncValue.guard(() async {
        await ref.watch(
          updateBoardProvider
              .call(board: value.previous, title: value.title, content: value.content, category: value.category)
              .future,
        );

        return value.copyWith(isLoading: false);
      });
    }
  }
}
