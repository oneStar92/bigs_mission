part of '../view_model.dart';

@riverpod
bool isCreateFormValid(Ref ref) {
  final state = ref.watch(createViewModelProvider).valueOrNull;

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
