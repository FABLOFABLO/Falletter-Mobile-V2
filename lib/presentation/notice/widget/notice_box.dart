import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';

class NoticeBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isClicked;
  final VoidCallback? onTap;

  const NoticeBox({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isClicked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = isClicked
        ? FalletterColor.gray400
        : FalletterColor.white;
    const double size = 4;
    final text = FalletterTextStyle.body4.copyWith(
      color: FalletterColor.gray400,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: FalletterColor.middleBlack,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: FalletterTextStyle.subTitle2.copyWith(color: titleColor),
            ),
            const SizedBox(height: size),
            Text(subtitle, style: text.copyWith(color: titleColor)),
            const SizedBox(height: size),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time, style: text),
                Text('자세히 보기', style: text.copyWith(color: titleColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
