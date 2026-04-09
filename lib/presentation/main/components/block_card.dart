import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/components/modal/letter_modal.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:falletter_mobile_v2/presentation/main/provider/suspend_reason_provider.dart';
import 'package:flutter/material.dart';
import 'package:falletter_mobile_v2/models/main_notification_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlockCard extends ConsumerWidget {
  final MainNotificationModel notification;

  const BlockCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metaTextStyle = FalletterTextStyle.body4.copyWith(
      color: FalletterColor.gray400,
    );

    return ContentCardButton(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('⛔️', style: TextStyle(fontSize: 19)),
                SizedBox(width: 6),
                Text(notification.title, style: FalletterTextStyle.subTitle2),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '정책 위반으로 인해 계정 이용이 ', style: metaTextStyle),
                    TextSpan(
                      text: '${notification.days}일 ',
                      style: metaTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.textColor,
                      ),
                    ),
                    TextSpan(text: '동안 제한됩니다.', style: metaTextStyle.copyWith(color: context.textColor)),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  timeCheck(notification.createdAt),
                  style: metaTextStyle.copyWith(color: FalletterColor.gray500),
                ),
                SizedBox(width: 6),
                GestureDetector(
                  onTap: () async {
                    try {
                      if (notification.suspendId == null) return;
                      await ref
                          .read(suspendReasonProvider.notifier)
                          .loadSuspendReason(notification.suspendId!);
                      final reason = ref.read(suspendReasonProvider);

                      if (reason != null) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return LetterModal(
                              dear: '서비스 정지 사유',
                              content: reason.reason,
                              bottom: '',
                            );
                          },
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    '자세히 보기',
                    style: metaTextStyle.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: FalletterColor.gray500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
