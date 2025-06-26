part of '../view_model.dart';

@riverpod
bool isUpdateFormValid(Ref ref, BoardEntity board) {
  final state = ref.watch(updateViewModelProvider(previous: board)).valueOrNull;

  if (state == null) return false;

  final title = state.title;
  final content = state.content;
  final category = state.category;

  if (title.isEmpty || content.isEmpty || category == null) {
    return false;
  } else {
    return true;
  }
}
