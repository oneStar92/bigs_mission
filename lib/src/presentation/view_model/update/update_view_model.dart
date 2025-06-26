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

  onChangeTitle(String title) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(title: title));
    }
  }

  onChangeContent(String content) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(content: content));
    }
  }

  onChangeCategory(Category? category) {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(category: category));
    }
  }

  Future<void> updateBoard() async {
    final value = state.valueOrNull;

    if (value != null && !value.isLoading && value.category != null) {
      state = AsyncValue.data(value.copyWith(isLoading: true));

      try {
        await ref.watch(
          updateBoardProvider
              .call(board: value.previous, title: value.title, content: value.content, category: value.category!)
              .future,
        );
        ref
            .read(detailViewModelProvider(id: value.previous.id).notifier)
            .updated(value.title, value.content, value.category!);
        ref
            .read(homeViewModelProvider.notifier)
            .updateBoard(value.previous.id, value.title, value.content, value.category!);
      } catch (e) {
        throw UpdateFailedException();
      } finally {
        state = AsyncValue.data(value.copyWith(isLoading: false));
      }
    }
  }
}
