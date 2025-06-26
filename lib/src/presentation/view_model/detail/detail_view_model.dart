part of '../view_model.dart';

@riverpod
class DetailViewModel extends _$DetailViewModel {
  @override
  FutureOr<DetailState> build({required int id}) async {
    return _fetchData(id: id);
  }

  Future<DetailState> _fetchData({required int id}) async {
    final board = await ref.watch(fetchBoardDetailProvider.call(id: id).future);
    return DetailState(board: board);
  }

  Future<void> updated(String title, String content, Category category) async {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(
        value.copyWith(board: value.board.copyWith(title: title, content: content, category: category)),
      );
    }
  }

  Future<void> delete() async {
    final value = state.valueOrNull;

    if (value != null) {
      state = AsyncValue.data(value.copyWith(isLoading: true));

      try {
        await ref.watch(deleteBoardProvider.call(id: value.board.id).future);
        ref.read(homeViewModelProvider.notifier).deleteBoard(value.board.id);
      } catch (e) {
        rethrow;
      } finally {
        state = AsyncValue.data(value.copyWith(isLoading: false));
      }
    }
  }
}
