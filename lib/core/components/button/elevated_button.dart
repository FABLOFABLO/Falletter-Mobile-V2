import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_mode_provoder.dart';
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
        gradient: _getGradient(isEnabled, themeColors, context, ref),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          overlayColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: DefaultTextStyle(
          style: _getTextStyle(context, isEnabled, ref),
          textAlign: TextAlign.center,
          child: child,
        ),
      ),
    );
  }

  Gradient _getGradient(bool isEnabled, ThemeColors themeColors, BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    if (!isEnabled) {
      final disabledColor = isDark ? FalletterColor.gray800 : FalletterColor.gray300;
      return FalletterGradient.horizontal([disabledColor, disabledColor]);
    }
    return gradient ?? themeColors.button;
  }

  TextStyle _getTextStyle(BuildContext context, bool isEnabled, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return FalletterTextStyle.button.copyWith(
      color: isEnabled
          ? (textColor ?? context.reverseTextColor)
          : isDark ? FalletterColor.gray500 : FalletterColor.middleWhite,
    );
  }
}