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

  Future<void> refresh() async {
    state = AsyncValue.data(
      HomeState(
        isLoading: true,
        boards: List.empty(growable: true),
        currentPageNumber: 0,
        hasNext: true,
        isEmpty: false,
      ),
    );

    final boardsPage = await ref.watch(fetchInitialPageProvider.future);

    state = AsyncValue.data(
      HomeState(
        isLoading: false,
        boards: List.from(boardsPage.boards),
        currentPageNumber: 0,
        hasNext: boardsPage.hasNext,
        isEmpty: boardsPage.isEmpty,
      ),
    );
  }

  void updateBoard(int id, String title, String content, Category category) {
    final current = state.valueOrNull;
    if (current == null) return;

    final updatedBoards =
        current.boards.map((b) {
          return b.id == id ? b.copyWith(title: title, category: category) : b;
        }).toList();
    state = AsyncValue.data(current.copyWith(boards: updatedBoards));
  }

  void deleteBoard(int id) {
    final current = state.valueOrNull;
    if (current == null) return;

    final updatedBoards = current.boards.where((b) => b.id != id).toList();

    state = AsyncValue.data(current.copyWith(boards: updatedBoards));
  }

  void create(BoardItemEntity board) {
    final current = state.valueOrNull;
    if (current == null) return;

    final newBoards = List<BoardItemEntity>.from(current.boards); // ✅ 수정 가능 복사본
    newBoards.add(board);
    state = AsyncValue.data(current.copyWith(boards: newBoards));
  }
}
