import 'package:bigs/src/core/core.dart';
import 'package:bigs/src/presentation/view/home/widget/board_widget.dart';
import 'package:bigs/src/presentation/view_model/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Colors.white,
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(homeViewModelProvider);
          if (state is AsyncData) {
            return _buildBody(context);
          } else if (state is AsyncError) {
            return Center(child: Text('알 수 없는 오류로 데이터를 불러오는데 실패했습니다.'));
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        shape: CircleBorder(),
        child: Icon(Icons.add),
        onPressed: () {
          context.goNamed(createName);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 0,
      leading: SizedBox.shrink(),
      centerTitle: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text('Bigs', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800)),
            Spacer(),
            PopupMenuButton(
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
                          await TokenStorage.instance.deleteToken();
                        },
                        contentPadding: EdgeInsets.zero,
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 4,
                            children: [Icon(Icons.logout), Text('로그아웃')],
                          ),
                        ),
                      ),
                    ),
                  ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200) {
          ref.read(homeViewModelProvider.notifier).fetchMore();
        }
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: CustomScrollView(
          slivers: [
            CupertinoSliverRefreshControl(onRefresh: () => ref.read(homeViewModelProvider.notifier).refresh()),
            Consumer(
              builder: (context, ref, child) {
                final boards = ref.watch(homeViewModelProvider).valueOrNull?.boards ?? [];
                return SliverList.separated(
                  itemCount: boards.length,
                  itemBuilder: (context, index) {
                    final board = boards[index];
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(detailName, pathParameters: {'id': '${board.id}'});
                      },
                      child: BoardWidget(
                        title: board.title,
                        category: board.category.toString(),
                        timeAgo: _timeAgo(board.createdAt),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final hasNext = ref.watch(homeViewModelProvider).valueOrNull?.hasNext ?? false;
                return SliverToBoxAdapter(
                  child:
                      hasNext
                          ? SizedBox(height: 120, child: Center(child: CupertinoActivityIndicator()))
                          : SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
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
