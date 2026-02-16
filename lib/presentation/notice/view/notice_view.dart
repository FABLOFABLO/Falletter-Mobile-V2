import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/presentation/notice/view/notice_detail_view.dart';
import 'package:falletter_mobile_v2/presentation/notice/widget/notice_box.dart';
import 'package:flutter/material.dart';
import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';

class FalletterNoticeView extends StatelessWidget {
  const FalletterNoticeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FalletterColor.black,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              count: 10,
              icon: false,
              appBarAction: AppBarAction.brickCount,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return ContentCardButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FalletterNoticeDetailView(),
                        ),
                      );
                    },
                    child: NoticeBox(
                      title: '3학년 여학생의 선택',
                      subtitle: '가장 보고싶은 사람은?',
                      time: '1시간 전',
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
}
