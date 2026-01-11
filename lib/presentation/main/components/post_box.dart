import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';

class PostBox extends StatelessWidget {
  final String title;
  final String text;
  final String nickname;
  final String time;
  final int comment;

  const PostBox({
    super.key,
    required this.title,
    required this.text,
    required this.nickname,
    required this.time,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {

    return Center(
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: 350,
              height: 108,
              decoration: BoxDecoration(
                color: FalletterColor.middleBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 25, left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: FalletterTextStyle.subTitle2),
                    SizedBox(height: 5),
                    Text(
                      text,
                      style: FalletterTextStyle.body4.copyWith(
                        color: FalletterColor.gray400,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(nickname, style: FalletterTextStyle.body4.copyWith(
                          color: FalletterColor.gray500
                        )),
                        SizedBox(width: 8),
                        Text(time, style: FalletterTextStyle.body4.copyWith(
                            color: FalletterColor.gray500
                        )),
                        SizedBox(width: 8),
                        Text('댓글 $comment개', style: FalletterTextStyle.body4.copyWith(
                            color: FalletterColor.white
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
