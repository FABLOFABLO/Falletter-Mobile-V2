import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/progress/loading_progress_indicator.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/features/notification/presentation/widget/detail_notification.dart';
import 'package:falletter_mobile_v2/features/notification/presentation/provider/notification_setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotificationSettingView extends ConsumerWidget {
  const NotificationSettingView({super.key});

  static double height = 10;
  static double spaceHeight = 14;
  static double spacing = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(notificationSettingProvider);
    final notifier = ref.read(notificationSettingProvider.notifier);

    if (setting == null) {
      Future.microtask(() {
        notifier.loadSetting();
      });
      return loadingCircularIndicator(ref);
    }

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
              isEnabled: setting.pushEnabled,
              onTap: (value) => notifier.toggle(NotificationSettingType.push, value)
            ),
            SizedBox(height: NotificationSettingView.spaceHeight),
            DetailNotification(
              title: '댓글 알림 받기',
              isEnabled: setting.commentEnabled,
              onTap: (value) => notifier.toggle(NotificationSettingType.comment, value)
            ),
            divider(context),
            DetailNotification(
              title: '브릭 활성화 알림 받기',
              isEnabled: setting.brickActivationEnabled,
              onTap: (value) => notifier.toggle(NotificationSettingType.brickActivation, value)
            ),
            SizedBox(height: NotificationSettingView.spaceHeight),
            DetailNotification(
              title: '브릭 알림 받기',
              isEnabled: setting.brickEnabled,
              onTap: (value) => notifier.toggle(NotificationSettingType.brick, value),
            ),
            divider(context),
            DetailNotification(
              title: '레터 알림 받기',
              isEnabled: setting.letterEnabled,
              onTap: (value) => notifier.toggle(NotificationSettingType.letter, value),
            ),
            SizedBox(height: NotificationSettingView.spaceHeight),
            DetailNotification(
              title: '레터 전송 완료 알림 받기',
              isEnabled: setting.letterSentEnabled,
              onTap: (value) => notifier.toggle(NotificationSettingType.letterSent, value),
            ),
            divider(context),
            DetailNotification(
              title: '관리자 공지 알림 받기',
              isEnabled: setting.adminNoticeEnabled,
              onTap: (value) => notifier.toggle(NotificationSettingType.adminNotice, value),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: CustomElevatedButton(
                width: double.infinity,
                child: Text('적용하기', style: TextStyle(color: context.reverseTextColor)),
                onPressed: () async {
                  await notifier.editSetting();
                  context.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: NotificationSettingView.spacing),
        Divider(thickness: 4, color: context.cardBg),
        SizedBox(height: NotificationSettingView.spaceHeight),
      ],
    );
  }
}
