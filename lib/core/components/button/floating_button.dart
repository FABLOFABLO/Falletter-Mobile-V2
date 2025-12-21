import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class CustomFloatingButton extends ConsumerWidget {
  const CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    final screenWidth = MediaQuery.of(context).size.width;
    final fabSize = screenWidth * 0.15;

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: fabSize,
        height: fabSize,
        decoration: BoxDecoration(
          gradient: themeColors.button,
          shape: BoxShape.circle,
        ),
        child: const Icon(
            Symbols.add,
            fill: 1,
            size: 40,
            color: FalletterColor.black,
        ),
      ),
    );
  }
}
