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
}