import 'dart:async';

import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/bottom_nav_provider.dart';
import 'package:falletter_mobile_v2/presentation/notice/provider/notice_provider.dart';
import 'package:falletter_mobile_v2/presentation/notice/widget/notice_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:go_router/go_router.dart';

class FalletterNoticeView extends ConsumerStatefulWidget {
  const FalletterNoticeView({super.key});

  @override
  ConsumerState<FalletterNoticeView> createState() =>
      _FalletterNoticeViewState();
}

class _FalletterNoticeViewState extends ConsumerState<FalletterNoticeView> {
  final Set<int> _readNoticeIds = {};
  Timer? _autoRefreshTimer;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(noticeListProvider.notifier).loadNotices();
    });
    _autoRefreshTimer = Timer.periodic(
      const Duration(hours: 1),
      (_) => _refreshNotices(),
    );
  }

  @override
  void dispose() {
    _autoRefreshTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void resetScroll() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _refreshNotices() async {
    await ref.read(noticeListProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final brickCount = ref.watch(brickCountProvider);
    final noticeState = ref.watch(noticeListProvider);

    ref.listen(bottomNavIndexProvider, (previous, current) {
      if (current == 3) {
        Future.microtask(() => resetScroll());
      }
    });

    return Scaffold(
      backgroundColor: context.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              icon: false,
              appBarAction: AppBarAction.brickCount,
              count: brickCount,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshNotices,
                backgroundColor: context.middleColor,
                child: _buildBody(noticeState),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(NoticeListState noticeState) {
    if (noticeState.isLoading && noticeState.notices.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (noticeState.error != null && noticeState.notices.isEmpty) {
      return Center(
        child: Text('알림을 불러올 수 없습니다.', style: FalletterTextStyle.body2),
      );
    }

    if (noticeState.notices.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: const Center(
              child: Text(
                '받은 알림이 없습니다',
              ),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: noticeState.notices.length,
      itemBuilder: (context, index) {
        final notice = noticeState.notices[index];
        final isRead = notice.isRead || _readNoticeIds.contains(notice.id);

        return NoticeBox(
          title: notice.gradeGenderLabel,
          subtitle: notice.question,
          time: notice.timeAgo,
          isClicked: isRead,
          onTap: () async {
            await context.push('/notice/detail', extra: notice);
            setState(() {
              _readNoticeIds.add(notice.id);
            });
          },
        );
      },
    );
  }
}
