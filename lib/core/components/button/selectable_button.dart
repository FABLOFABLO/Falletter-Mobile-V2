import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectableButton extends ConsumerWidget {
  final String label;
  final IconData? icon;
  final Widget? iconWidget;
  final Color? iconColor;
  final Gradient? iconGradient;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableButton({
    super.key,
    required this.label,
    this.icon,
    this.iconWidget,
    this.iconColor,
    this.iconGradient,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
          gradient: themeColors.answerButton,
          borderRadius: BorderRadius.circular(8),
        )
            : null,
        padding: isSelected ? const EdgeInsets.all(2) : EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            color: FalletterColor.middleBlack,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: _buildIcon(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Text(
                  label,
                  style: FalletterTextStyle.title2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (iconWidget != null) {
      return iconWidget!;
    }

    if (iconGradient != null) {
      return ShaderMask(
        shaderCallback: (bounds) => iconGradient!.createShader(bounds),
        child: Icon(
            icon,
            color: FalletterColor.white,
            size: 100,
            fill: 1,
        ),
      );
    }

    return Icon(
        icon,
        color: iconColor,
        size: 100,
        fill: 1,
    );
  }
}
