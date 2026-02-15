import 'dart:ui';

import 'package:falletter_mobile_v2/core/components/gradient_text.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/presentation/roulette/components/roulette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouletteView extends ConsumerWidget {
  const RouletteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final themeColors = appThemeColors[theme]!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: FalletterColor.black.withAlpha(204),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Text('누군지 알 수 있는', style: FalletterTextStyle.title3),
                  ),
                  GradientText(
                      text: '출석체크 랜덤 블록',
                      gradient: themeColors.primaryGradient,
                      style: FalletterTextStyle.title1
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Roulette(),
                  )
                ],
              ),
            )
          ),
        ]
      ),
    );
  }
}
