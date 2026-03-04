import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/mypage/widget/detail_notification.dart';
import 'package:flutter/material.dart';

class NotificationSettingView extends StatefulWidget {
  const NotificationSettingView({super.key});

  static double height = 10;
  static double spaceHeight = 14;
  static double spacing = 20;

  @override
  State<NotificationSettingView> createState() =>
      _NotificationSettingViewState();
}

class _NotificationSettingViewState extends State<NotificationSettingView> {
  final Map<String, bool> notification = {
    '푸시 알림 받기': true,
    '댓글 알림 받기': true,
    '브릭 활성화 알림 받기': true,
    '브릭 알림 받기': true,
    '레터 알림 받기': true,
    '레터 전송 완료 알림 받기': true,
    '관리자 공지 알림 받기': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(icon: true, title: '알림'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: NotificationSettingView.spacing),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: NotificationSettingView.spacing,
              ),
              child: Text(
                '알림 설정',
                style: FalletterTextStyle.placeholder.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: NotificationSettingView.height),
            DetailNotification(
              title: '푸시 알림 받기',
              isEnabled: notification['푸시 알림 받기']!,
              onTap: (value) {
                setState(() {
                  notification['푸시 알림 받기'] = value;
                });
              },
            ),
            SizedBox(height: NotificationSettingView.spaceHeight),
            DetailNotification(
              title: '댓글 알림 받기',
              isEnabled: notification['댓글 알림 받기']!,
              onTap: (value) {
                setState(() {
                  notification['댓글 알림 받기'] = value;
                });
              },
            ),
            divider(),
            DetailNotification(
              title: '브릭 활성화 알림 받기',
              isEnabled: notification['브릭 활성화 알림 받기']!,
              onTap: (value) {
                setState(() {
                  notification['브릭 활성화 알림 받기'] = value;
                });
              },
            ),
            SizedBox(height: NotificationSettingView.spaceHeight),
            DetailNotification(
              title: '브릭 알림 받기',
              isEnabled: notification['브릭 알림 받기']!,
              onTap: (value) {
                setState(() {
                  notification['브릭 알림 받기'] = value;
                });
              },
            ),
            divider(),
            DetailNotification(
              title: '레터 알림 받기',
              isEnabled: notification['레터 알림 받기']!,
              onTap: (value) {
                setState(() {
                  notification['레터 알림 받기'] = value;
                });
              },
            ),
            SizedBox(height: NotificationSettingView.spaceHeight),
            DetailNotification(
              title: '레터 전송 완료 알림 받기',
              isEnabled: notification['레터 전송 완료 알림 받기']!,
              onTap: (value) {
                setState(() {
                  notification['레터 전송 완료 알림 받기'] = value;
                });
              },
            ),
            divider(),
            DetailNotification(
              title: '관리자 공지 알림 받기',
              isEnabled: notification['관리자 공지 알림 받기']!,
              onTap: (value) {
                setState(() {
                  notification['관리자 공지 알림 받기'] = value;
                });
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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

  Widget divider() {
    return Column(
      children: [
        SizedBox(height: NotificationSettingView.spacing),
        Divider(thickness: 4, color: FalletterColor.middleBlack),
        SizedBox(height: NotificationSettingView.spaceHeight),
      ],
    );
  }
}
