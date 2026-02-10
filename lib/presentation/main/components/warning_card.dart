import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WarningCard extends StatefulWidget {
  const WarningCard({super.key});

  @override
  State<WarningCard> createState() => _WarningCardState();
}

class _WarningCardState extends State<WarningCard> {
  final metaTextStyle = FalletterTextStyle.body4;
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
                SvgPicture.asset('assets/svg/suspend/warning.svg'),
                SizedBox(width: 6),
                Text('정책 위반 행위 경고 안내', style: FalletterTextStyle.subTitle2)
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text('추가 위반 시 계정 이용이 제한될 수 있으니 주의해 주세요.',
                  style: metaTextStyle.copyWith(color: FalletterColor.gray400)),
            ),
            // TODO: 연동할 때 상태관리로 수정
            Text('45분 전', style: metaTextStyle.copyWith(color: FalletterColor.gray500))
          ],
        ),
      ),
      onTap: () {}
    );
  }
}
