import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falletter_mobile_v2/models/main_notification_model.dart';

class WarningCard extends StatelessWidget {
  final MainNotificationModel notification;

  const WarningCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
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
                SvgPicture.asset('assets/svg/suspend/warning.svg'),
                SizedBox(width: 6),
                Text(notification.title, style: FalletterTextStyle.subTitle2),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                '추가 위반 시 계정 이용이 제한될 수 있으니 주의해 주세요.',
                style: metaTextStyle,
              ),
            ),
            Text(
              timeCheck(notification.createdAt),
              style: metaTextStyle.copyWith(color: FalletterColor.gray500),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
