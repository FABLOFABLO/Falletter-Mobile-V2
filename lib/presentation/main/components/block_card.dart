import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/components/modal/default_modal.dart';
import 'package:falletter_mobile_v2/core/components/modal/letter_modal.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlockCard extends StatefulWidget {
  final int days;

  const BlockCard({super.key, required this.days});

  @override
  State<BlockCard> createState() => _BlockCardState();
}

class _BlockCardState extends State<BlockCard> {
  final metaTextStyle = FalletterTextStyle.body4.copyWith(
    color: FalletterColor.gray400,
  );

  @override
  Widget build(BuildContext context) {
    return ContentCardButton(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('⛔️', style: TextStyle(fontSize: 20)),
                SizedBox(width: 8),
                Text(
                  '계정 이용 일시 정지 안내',
                  style: FalletterTextStyle.subTitle2,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '정책 위반으로 인해 계정 이용이 ',
                      style: metaTextStyle,
                    ),
                    TextSpan(
                      text: '${widget.days}일 ',
                      style: metaTextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(text: '동안 제한됩니다.', style: metaTextStyle),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  // TODO: 연동할 때 api 자세히 질문하고 상태관리로 바꾸기
                  '45분 전',
                  style: metaTextStyle.copyWith(
                    color: FalletterColor.gray500,
                  ),
                ),
                SizedBox(width: 6),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LetterModal(
                            dear: '서비스 정지 사유',
                            content: '귀하의 계정은 서비스 이용 중 타인에게 불쾌감이나 피해를 줄 수 있는 부적절한 언행이 확인되어, 운영 정책에 따라 일시적으로 이용이 7일 제한되었습니다.',
                            bottom: '',
                          );
                        }
                    );
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
