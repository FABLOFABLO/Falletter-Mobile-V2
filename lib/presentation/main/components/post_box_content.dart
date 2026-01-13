import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:flutter/material.dart';

class PostBoxContent extends StatelessWidget {
  final String title;
  final String text;
  final String nickname;
  final String time;
  final int comment;

  const PostBoxContent({
    super.key,
    required this.title,
    required this.text,
    required this.nickname,
    required this.time,
    required this.comment
  });

  @override
  Widget build(BuildContext context) {
    return ContentCardButton(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: FalletterTextStyle.subTitle2),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Text(
              text,
              style: FalletterTextStyle.body4.copyWith(
                color: FalletterColor.gray400,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                nickname,
                style: FalletterTextStyle.body4.copyWith(
                  color: FalletterColor.gray500,
                ),
              ),
              SizedBox(width: 8),
              Text(
                time,
                style: FalletterTextStyle.body4.copyWith(
                  color: FalletterColor.gray500,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '댓글 $comment개',
                style: FalletterTextStyle.body4.copyWith(
                  color: FalletterColor.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
