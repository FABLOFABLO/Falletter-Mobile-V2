import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomElevatedButton extends ConsumerWidget {
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final Gradient? gradient;
  final Color? textColor;
  final Widget child;

  const CustomElevatedButton({
    super.key,
    this.width = 350,
    this.height = 52,
    this.onPressed,
    this.gradient,
    this.textColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isEnabled = onPressed != null;
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: _getGradient(isEnabled, themeColors),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        child: DefaultTextStyle(
          style: _getTextStyle(isEnabled),
          textAlign: TextAlign.center,
          child: child,
        ),
      ),
    );
  }

  Gradient _getGradient(bool isEnabled, ThemeColors themeColors) {
    if (!isEnabled) {
      return FalletterGradient.horizontal([
        FalletterColor.gray900,
        FalletterColor.gray900,
      ]);
    }
    return gradient ?? themeColors.button;
  }

  TextStyle _getTextStyle(bool isEnabled) {
    return FalletterTextStyle.button.copyWith(
      color: isEnabled
          ? (textColor ?? FalletterColor.middleBlack)
          : FalletterColor.gray500,
    );
  }
}