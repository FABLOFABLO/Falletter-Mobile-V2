import 'package:falletter_mobile_v2/core/constants/app_theme_color.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class MainHeader extends ConsumerWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: SvgPicture.asset(themeColors.rouletteCheckSvg),
              onTap: () {},
            ),
            const SizedBox(width: 10),
            GestureDetector(
              child: SvgPicture.asset(themeColors.noticeSvg),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
