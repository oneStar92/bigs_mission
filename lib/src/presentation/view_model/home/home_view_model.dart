part of '../view_model.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  FutureOr<HomeState> build() async {
    return _fetchData();
  }

  Future<HomeState> _fetchData() async {
    final boardsPage = await ref.watch(fetchInitialPageProvider.future);
    return HomeState(
      isLoading: false,
      boards: List.from(boardsPage.boards),
      currentPageNumber: 0,
      hasNext: boardsPage.hasNext,
      isEmpty: boardsPage.isEmpty,
    );
  }

  Future<void> fetchMore() async {
    final value = state.valueOrNull;

    if (value != null && !value.isEmpty && value.hasNext && !value.isLoading) {
      state = AsyncValue.data(value.copyWith(isLoading: true));

      state = await AsyncValue.guard(() async {
        final newPage = await ref.watch(fetchNextPageProvider.call(pageNumber: value.currentPageNumber + 1).future);

        return value.copyWith(
          isLoading: false,
          hasNext: newPage.hasNext,
          boards: List.from(value.boards)..addAll(newPage.boards),
          currentPageNumber: newPage.number,
          isEmpty: newPage.isEmpty,
        );
      });
    }
  }
}
