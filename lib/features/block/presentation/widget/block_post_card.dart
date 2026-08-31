import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/utils/time_utils.dart';
import 'package:flutter/material.dart';

class BlockPostCard extends StatelessWidget {
  final String title;
  final String content;
  final String nickname;
  final DateTime blockedAt;
  final VoidCallback onTap;

  const BlockPostCard({
    super.key,
    required this.title,
    required this.content,
    required this.nickname,
    required this.blockedAt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ContentCardButton(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: FalletterTextStyle.subTitle2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  timeCheck(blockedAt),
                  style: FalletterTextStyle.body4.copyWith(
                    color: FalletterColor.gray500,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                content,
                style: FalletterTextStyle.body4.copyWith(
                  color: FalletterColor.gray400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(nickname, style: FalletterTextStyle.body4),
          ],
        ),
      ),
    );
  }
}
