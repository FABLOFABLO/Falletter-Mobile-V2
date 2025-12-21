import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_mode_provoder.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final backgroundColor =
    isDark ? FalletterColor.darkTheme : FalletterColor.lightTheme;

    final circleGradient = themeColors.toggleCircleColor;

    final iconPath = isDark
        ? 'assets/svg/theme_mode/dark.svg'
        : 'assets/svg/theme_mode/light.svg';

    return GestureDetector(
      onTap: () {
        ref.read(themeModeProvider.notifier).state =
        isDark ? ThemeMode.light : ThemeMode.dark;
      },
      child: AnimatedContainer(
        width: 48,
        height: 26,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment:
              isDark ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  gradient: circleGradient,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}