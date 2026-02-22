import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/mypage/widget/detail_notification.dart';
import 'package:flutter/material.dart';

class NotificationSettingView extends StatelessWidget {
  const NotificationSettingView({super.key});

  static double height = 10;
  static double spaceHeight = 14;
  static double spacing = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(icon: true, title: '알림'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: spacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing),
              child: Text(
                '알림 설정',
                style: FalletterTextStyle.placeholder.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: height),
            DetailNotification(title: '푸시 알림 받기'),
            SizedBox(height: spaceHeight),
            DetailNotification(title: '댓글 알림 받기'),
            divider(),
            DetailNotification(title: '브릭 활성화 알림 받기'),
            SizedBox(height: spaceHeight),
            DetailNotification(title: '브릭 알림 받기'),
            divider(),
            DetailNotification(title: '레터 알림 받기'),
            SizedBox(height: spaceHeight),
            DetailNotification(title: '레터 전송 완료 알림 받기'),
            divider(),
            DetailNotification(title: '관리자 공지 알림 받기'),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
              child: CustomElevatedButton(
                width: double.infinity,
                child: Text('적용하기'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget divider(){
   return Column(
     children: [
       SizedBox(height: spacing),
       Divider(thickness: 4, color: FalletterColor.middleBlack),
       SizedBox(height: spaceHeight),
     ],
   );
  }
}
