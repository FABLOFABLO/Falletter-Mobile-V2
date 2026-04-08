import 'dart:async';
import 'package:falletter_mobile_v2/core/components/progress/circle_progress.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/answer_timer_provider.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerTimerView extends ConsumerStatefulWidget {

  const AnswerTimerView({super.key});

  @override
  ConsumerState<AnswerTimerView> createState() => _AnswerTimerViewState();
}

class _AnswerTimerViewState extends ConsumerState<AnswerTimerView> {

  @override
  Widget build(BuildContext context) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    final timer = ref.watch(answerTimerProvider);
    final remainingSeconds = ref.watch(answerCountdownProvider);

    final duration = Duration(seconds: remainingSeconds);
    final totalSeconds = 14400;

    final minutes =
    duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours.toString().padLeft(2, '0');

    final progress = totalSeconds > 0
        ? remainingSeconds / totalSeconds
        : 0.0;

    if (timer != null && timer.isActive && remainingSeconds == 0) {
      Future.microtask(() {
        ref.read(answerCountdownProvider.notifier)
            .startTimer(timer.remainingSeconds);
      });
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text('다음 질문까지 남은 시간',
                style: FalletterTextStyle.button
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: context.cardBg,
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
                decoration: BoxDecoration(
                  color: context.cardBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$hours:$minutes',
                  style: FalletterTextStyle.title1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}