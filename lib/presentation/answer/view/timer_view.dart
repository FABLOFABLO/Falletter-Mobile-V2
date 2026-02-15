import 'package:falletter_mobile_v2/core/components/progress/circle_progress.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerView extends ConsumerWidget {
  final Duration countdown;
  final Duration initialCountdown;

  const TimerView({
    super.key,
    required this.countdown,
    required this.initialCountdown,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    final minutes = countdown.inMinutes.remainder(60).toString().padLeft(2, '0');
    final hours = countdown.inHours.toString().padLeft(2, '0');
    final progress = initialCountdown.inSeconds > 0
        ? countdown.inSeconds / initialCountdown.inSeconds : 0.0;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text('다음 질문까지 남은 시간',
                style: FalletterTextStyle.button.copyWith(
                  color: FalletterColor.gray200,
                )),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: FalletterColor.middleBlack,
                  shape: BoxShape.circle,
                ),
              ),
              CustomPaint(
                size: Size(200, 200),
                painter: CircleProgress(
                  progress: progress,
                  strokeWidth: 10,
                  gradient: themeColors.primaryGradient,
                ),
              ),
              Container(
                width: 190,
                height: 190,
                decoration: const BoxDecoration(
                  color: FalletterColor.middleBlack,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$hours:$minutes',
                  style: FalletterTextStyle.title1.copyWith(
                    color: FalletterColor.gray50,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}