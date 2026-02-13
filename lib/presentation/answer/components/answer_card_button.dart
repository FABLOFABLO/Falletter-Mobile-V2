import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerCardButton extends ConsumerWidget {
  final String name;
  final double? width;
  final bool isSelected;
  final VoidCallback? onTap;

  const AnswerCardButton({
    super.key,
    required this.name,
    this.width,
    required this.isSelected,
    required this.onTap
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
              width: width ?? double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: FalletterColor.middleBlack,
                gradient: (isSelected) ? themeColors.primaryGradient : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(name, style: FalletterTextStyle.title3.copyWith(
                    color: (isSelected) ? FalletterColor.black : null
                ),),
              )
          ),
        ),
      ),
    );
  }
}