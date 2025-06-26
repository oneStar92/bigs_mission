import 'package:bigs/src/core/core.dart';
import 'package:bigs/src/domain/entity/entity.dart';
import 'package:bigs/src/presentation/view/common/text_style/text_style.dart';
import 'package:bigs/src/presentation/view/common/widget/back_button.dart';
import 'package:bigs/src/presentation/view/common/widget/loading_barrier.dart';
import 'package:bigs/src/presentation/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends ConsumerWidget {
  final String boardId;

  const DetailScreen({required this.boardId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detailViewModelProvider(id: int.parse(boardId)));

    return Stack(
      children: state.when(
        data:
            (detailState) => [
              Scaffold(
                appBar: _buildAppBar(context, ref, detailState.board),
                body: _buildBody(context, detailState.board),
              ),
            ],
        error: (e, st) => [_buildEmpty(context, '게시글을 불러오는데 실패했습니다.')],
        loading: () => [_buildEmpty(context, ''), LoadingBarrier()],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, String message) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        titleSpacing: 0,
        centerTitle: false,
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
              const Center(child: Text('상세 화면')),
            ],
          ),
        ),
      ),
      body: Center(child: message.isNotEmpty ? Text(message, style: smallTextStyle) : SizedBox.shrink()),
    );
  }

  AppBar _buildAppBar(BuildContext context, WidgetRef ref, BoardEntity board) {
    return AppBar(
      leading: const SizedBox.shrink(),
      leadingWidth: 0,
      titleSpacing: 0,
      centerTitle: false,
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
            const Center(child: Text('상세 화면')),
            Positioned(
              right: 0,
              child: PopupMenuButton(
                popUpAnimationStyle: AnimationStyle(
                  curve: Easing.emphasizedDecelerate,
                  duration: const Duration(milliseconds: 300),
                ),
                position: PopupMenuPosition.under,
                color: Color(0xFFF5F5F5),
                elevation: 0,
                icon: Icon(Icons.more_vert),
                padding: EdgeInsets.zero,
                menuPadding: EdgeInsets.zero,
                itemBuilder:
                    (context) => [
                      PopupMenuItem(
                        padding: EdgeInsets.zero,
                        child: ListTile(
                          onTap: () async {
                            context.pop();
                            ref.read(detailViewModelProvider(id: int.parse(boardId)).notifier).delete().then((_) {
                              context.pop();
                            }, onError: (_, __) {});
                          },
                          contentPadding: EdgeInsets.zero,
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 4,
                              children: [Icon(Icons.delete), Text('삭제')],
                            ),
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        padding: EdgeInsets.zero,
                        child: ListTile(
                          onTap: () async {
                            context.pop();
                            context.pushNamed(updateName, pathParameters: {'id': boardId}, extra: board);
                          },
                          contentPadding: EdgeInsets.zero,
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 4,
                              children: [Icon(Icons.edit), Text('수정')],
                            ),
                          ),
                        ),
                      ),
                    ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BoardEntity board) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(board.title, style: mediumTextStyle, textAlign: TextAlign.start),
          SizedBox(height: 6),
          Text('${board.category} | ${_timeAgo(board.createdAt)}', style: xSmallTextStyle, textAlign: TextAlign.start),
          SizedBox(height: 20),
          Text(board.content, style: smallTextStyle, maxLines: null),
        ],
      ),
    );
  }

  String _timeAgo(String isoTimeString) {
    final now = DateTime.now();
    final time = DateTime.parse(isoTimeString);
    final diff = now.difference(time);

    if (diff.inSeconds < 60) return '방금 전';
    if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
    if (diff.inHours < 24) return '${diff.inHours}시간 전';
    if (diff.inDays < 30) return '${diff.inDays}일 전';

    final months = (diff.inDays / 30).floor();
    if (months < 12) return '$months개월 전';

    final years = (diff.inDays / 365).floor();
    return '$years년 전';
  }
}
