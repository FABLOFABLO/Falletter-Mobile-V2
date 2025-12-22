import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class SendButton extends ConsumerWidget {
  final bool isEnabled;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const SendButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
    this.width = 48.0,
    this.height = 48.0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isEnabled ? null : FalletterColor.middleBlack,
          gradient: isEnabled ? themeColors.button : null,
        ),
        child: Icon(
          Symbols.send,
          size: 30,
          color: isEnabled
              ? FalletterColor.middleBlack
              : FalletterColor.gray800,
          fill: 1,
        ),
      ),
    );
  }
}
