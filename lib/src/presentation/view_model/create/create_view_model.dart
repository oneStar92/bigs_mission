part of '../view_model.dart';

@riverpod
class CreateViewModel extends _$CreateViewModel {
  @override
  FutureOr<CreateState> build() {
    return CreateState();
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

  onFocusTitle() {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(validateTitle: true));
    }
  }

  onFocusContent() {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(validateContent: true));
    }
  }

  validateAll() {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(validateTitle: true, validateContent: true, validateCategory: true));
    }
  }

  Future<void> create() async {
    final value = state.valueOrNull;

    if (value != null && !value.isLoading) {
      state = AsyncValue.data(value.copyWith(isLoading: true));

      try {
        final newBoard = await ref.watch(
          createBoardProvider(
            title: value.title,
            content: value.content,
            category: value.category ?? Category.etc,
          ).future,
        );
        ref.read(homeViewModelProvider.notifier).create(newBoard);
      } catch (e) {
        throw CreateFailedException();
      } finally {
        state = AsyncValue.data(value.copyWith(isLoading: false));
      }
    }
  }
}
