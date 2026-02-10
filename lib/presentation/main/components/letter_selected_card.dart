import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LetterSelectedCard extends ConsumerStatefulWidget {
  const LetterSelectedCard({super.key});

  @override
  ConsumerState<LetterSelectedCard> createState() => _LetterSelectedCardState();
}

class _LetterSelectedCardState extends ConsumerState<LetterSelectedCard> {
  @override
  Widget build(BuildContext context) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    return ContentCardButton(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(themeColors.letterSvg, width: 14, height: 14),
                  SizedBox(width: 6),
                  Expanded(child: Text('누군가 나를 선택했어요. 지금 확인해보세요!', style: FalletterTextStyle.subTitle2))
                ],
              ),
              SizedBox(height: 15),
              // TODO: 연동 때 상태관리로 변경
              Text('45분 전', style: FalletterTextStyle.body4.copyWith(color: FalletterColor.gray500))
            ],
          ),
        ),
        onTap: () {
          // TODO: 마이페이지 - 받은 레터 뷰 연결
        }
    );
  }
}
