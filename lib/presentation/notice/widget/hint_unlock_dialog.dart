import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HintUnlockDialog extends ConsumerWidget {
  final int requiredBricks;

  const HintUnlockDialog({super.key, required this.requiredBricks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "브릭 $requiredBricks개로 힌트를 보실건가요?",
              style: FalletterTextStyle.body1,
            ),
            const SizedBox(height: 32),
            _buildBrickIcon(themeColors),
            const SizedBox(height: 24),
            Text(
              "브릭 $requiredBricks개가 차감됩니다.",
              style: FalletterTextStyle.body2,
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    gradient: FalletterGradient.horizontal([
                      FalletterColor.gray200,
                      FalletterColor.gray200,
                    ]),
                    textColor: context.textColor,
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("취소"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("힌트보기"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrickIcon(ThemeColors themeColors) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(themeColors.brickSvg, height: 210, width: 210),
        Positioned(
          right: -40,
          bottom: 30,
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              "-$requiredBricks",
              style: FalletterTextStyle.title2,
            ),
          ),
        ),
      ],
    );
  }
}
