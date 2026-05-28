import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/features/letter/data/model/get_letter_model.dart';
import 'package:falletter_mobile_v2/features/user/presentation/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LetterPopup extends ConsumerWidget {
  final List<GetLetterModel> letters;

  const LetterPopup({
    super.key,
    required this.letters,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    final userInfo = ref.watch(userInfoProvider);

    final name = userInfo.when(
      data: (data) => data.name,
      loading: () => '',
      error: (_, __) => '',
    );

    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$name님께\n누군가의 편지가 도착했어요',
              style: FalletterTextStyle.body1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SvgPicture.asset(themeColors.receivedLetterSvg, width: 200),
          ],
        ),
      ),
    );
  }
}