import 'package:bigs/src/domain/entity/category/category.dart';
import 'package:bigs/src/domain/entity/entity.dart';
import 'package:bigs/src/presentation/view/common/extension/show_cupertino_alert.dart';
import 'package:bigs/src/presentation/view/common/text_style/text_style.dart';
import 'package:bigs/src/presentation/view/common/widget/back_button.dart';
import 'package:bigs/src/presentation/view/common/widget/future_button.dart';
import 'package:bigs/src/presentation/view_model/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UpdateScreen extends ConsumerStatefulWidget {
  final BoardEntity board;

  const UpdateScreen({super.key, required this.board});

  @override
  ConsumerState<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends ConsumerState<UpdateScreen> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();
  late final TextEditingController _titleTextEditingController;
  late final TextEditingController _contentTextEditingController;

  @override
  void initState() {
    _titleTextEditingController = TextEditingController(text: widget.board.title);
    _contentTextEditingController = TextEditingController(text: widget.board.content);
    _titleTextEditingController.addListener(() {
      ref
          .read(updateViewModelProvider(previous: widget.board).notifier)
          .onChangeTitle(_titleTextEditingController.text);
    });
    _contentTextEditingController.addListener(() {
      ref
          .read(updateViewModelProvider(previous: widget.board).notifier)
          .onChangeContent(_contentTextEditingController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _titleTextEditingController.removeListener(() {
      ref
          .read(updateViewModelProvider(previous: widget.board).notifier)
          .onChangeTitle(_titleTextEditingController.text);
    });
    _contentTextEditingController.removeListener(() {
      ref
          .read(updateViewModelProvider(previous: widget.board).notifier)
          .onChangeContent(_contentTextEditingController.text);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(updateViewModelProvider(previous: widget.board));

    return Scaffold(
      appBar: _buildAppBar(context),
      body: state.when(
        data: (detailState) => _buildBody(context),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, st) => Text('에러 발생: $e'),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: SizedBox.shrink(),
      leadingWidth: 0,
      titleSpacing: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      title: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: CustomBackButton(
                onTap: () {
                  context.pop();
                },
              ),
            ),
            const Center(child: Text('게시글 수정')),
            Positioned(
              right: 0,
              child: Consumer(
                builder: (context, ref, child) {
                  final isEnabled = ref.watch(isUpdateFormValidProvider(widget.board));

                  return FutureButton<void, UpdateException>(
                    onTap: () {
                      if (isEnabled) {
                        return ref.read(updateViewModelProvider(previous: widget.board).notifier).updateBoard();
                      } else {
                        throw CreateMissingFieldException();
                      }
                    },
                    onError: (e) {
                      switch (e) {
                        case UpdateFailedException():
                          context.showCupertinoAlert(message: e.message, title: '게시글 수정 실패');
                          break;
                        case UpdateMissingFieldException():
                          context.showCupertinoAlert(message: e.message, title: '게시글 수정 실패');
                          break;
                      }
                    },
                    onComplete: (_) {
                      context.pop('게시글 수정을 완료했어요.');
                    },
                    child: Text(
                      '수정하기',
                      style: smallTextStyle.copyWith(color: isEnabled ? Colors.black : CupertinoColors.systemGrey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final category = ref.watch(updateViewModelProvider(previous: widget.board)).valueOrNull?.category;
              return DropdownButton<Category>(
                hint: Text('게시글 주제를 선택해 주세요.', style: smallTextStyle.copyWith(color: Colors.black45)),
                elevation: 1,
                value: category,
                alignment: AlignmentDirectional.centerStart,
                items: [
                  DropdownMenuItem(value: Category.notice, child: Text('공지')),
                  DropdownMenuItem(value: Category.free, child: Text('자유')),
                  DropdownMenuItem(value: Category.qna, child: Text('Q&A')),
                  DropdownMenuItem(value: Category.etc, child: Text('기타')),
                ],
                onChanged: (value) {
                  ref.read(updateViewModelProvider(previous: widget.board).notifier).onChangeCategory(value);
                },
              );
            },
          ),
          TextFormField(
            focusNode: _titleFocusNode,
            controller: _titleTextEditingController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintStyle: smallTextStyle.copyWith(color: CupertinoColors.inactiveGray),
              hintText: '제목을 입력하세요.',
              errorText: null,
              contentPadding: EdgeInsets.zero,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            validator: null,
            style: smallTextStyle,
            cursorColor: Colors.black,
            cursorErrorColor: Colors.black,
            cursorHeight: 16,
            cursorWidth: 1,
            maxLines: 1,
            onTapOutside: (_) {
              if (_titleFocusNode.hasFocus) {
                _titleFocusNode.unfocus();
              }
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            focusNode: _contentFocusNode,
            controller: _contentTextEditingController,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              isDense: true,
              hintText: '게시글의 내용을 입력해 보세요.',
              hintStyle: xSmallTextStyle.copyWith(color: CupertinoColors.inactiveGray),
              contentPadding: EdgeInsets.zero,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            style: xSmallTextStyle,
            maxLines: null,
            cursorColor: Colors.black,
            cursorErrorColor: Colors.black,
            cursorHeight: 16,
            cursorWidth: 1,
          ),
        ],
      ),
    );
  }

  _showSubjectSelector({required Category? currentCategory}) async {
    final result = await showGeneralDialog<Category>(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, _, __) {
        return Stack(
          children: [
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 24, bottom: 16),
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.black26, width: 1)),
                            ),
                            child: Center(child: Text('주제', style: smallTextStyle)),
                          ),
                          ...List<Widget>.generate(Category.values.length, (index) {
                            final category = Category.values[index];
                            return GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        category.toString(),
                                        style: smallTextStyle.copyWith(
                                          color: currentCategory == category ? Colors.red : CupertinoColors.black,
                                        ),
                                      ),
                                    ),
                                    if (currentCategory == category)
                                      const Icon(Icons.check, size: 18, color: Colors.red),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );

    // if (result != null) {
    //   _onSelectedSubject(result);
    // }
  }

  // _onSelectedSubject(PostSubject subject) {
  //   context.read<PostWritePresenter>().onChangeSubject(subject);
  // }
}
