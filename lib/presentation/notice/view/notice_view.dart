import 'dart:async';

import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
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

  @override
  void initState() {
    super.initState();
    // 초기 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(noticeListProvider.notifier).loadNotices();
    });
    // 1시간마다 자동 새로고침
    _autoRefreshTimer = Timer.periodic(
      const Duration(hours: 1),
      (_) => _refreshNotices(),
    );
  }

  @override
  void dispose() {
    _autoRefreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _refreshNotices() async {
    await ref.read(noticeListProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final brickCount = ref.watch(brickCountProvider);
    final noticeState = ref.watch(noticeListProvider);

    return Scaffold(
      backgroundColor: FalletterColor.black,
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
                backgroundColor: FalletterColor.middleBlack,
                color: FalletterColor.white,
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
        child: CircularProgressIndicator(color: FalletterColor.white),
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
                style: TextStyle(color: FalletterColor.gray400),
              ),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
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
