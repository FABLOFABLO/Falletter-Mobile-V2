import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerButton extends ConsumerWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;
  final bool showBorder;
  final Gradient? borderGradient;
  final double height;

  const AnswerButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
    this.showBorder = false,
    this.borderGradient,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    final gradient = isSelected
        ? themeColors.answerButton
        : FalletterGradient.horizontal([
            FalletterColor.middleBlack,
            FalletterColor.middleBlack,
          ]);
    final hasBorder = showBorder;
    final textColor = isSelected ? FalletterColor.black : FalletterColor.white;

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: hasBorder ? borderGradient : null,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: hasBorder ? EdgeInsets.all(2) : EdgeInsets.zero,
      child: CustomElevatedButton(
        gradient: gradient,
        textColor: textColor,
        child: Text(
          label,
          style: FalletterTextStyle.title3.copyWith(color: textColor),
        ),
      ),
    );
  }
}
