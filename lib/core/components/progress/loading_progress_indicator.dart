import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget loadingCircularIndicator(WidgetRef ref) {
  final selectedTheme = ref.watch(themeProvider);
  final themeColors = appThemeColors[selectedTheme]!;

  return Center(
    child: ClipOval(
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return themeColors.progressIndicator.createShader(bounds);
        },
        child: const CircularProgressIndicator(
          strokeWidth: 8,
          color: Colors.white,
        ),
      ),
    ),
  );
}