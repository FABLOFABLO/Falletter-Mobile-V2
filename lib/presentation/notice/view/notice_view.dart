import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/presentation/notice/provider/notice_provider.dart';
import 'package:falletter_mobile_v2/presentation/notice/view/notice_detail_view.dart';
import 'package:falletter_mobile_v2/presentation/notice/widget/notice_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';

class FalletterNoticeView extends ConsumerStatefulWidget {
  const FalletterNoticeView({super.key});

  @override
  ConsumerState<FalletterNoticeView> createState() =>
      _FalletterNoticeViewState();
}

class _FalletterNoticeViewState extends ConsumerState<FalletterNoticeView> {
  final Set<int> _readIndices = {};

  @override
  Widget build(BuildContext context) {
    final brickCount = ref.watch(brickCountProvider);

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
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return NoticeBox(
                    title: '2학년 여학생의 선택',
                    subtitle: '웃는게 가장 예쁜 사람은?',
                    time: '30분전',
                    isClicked: _readIndices.contains(index),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FalletterNoticeDetailView(noticeIndex: index),
                        ),
                      );
                      setState(() {
                        _readIndices.add(index);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
