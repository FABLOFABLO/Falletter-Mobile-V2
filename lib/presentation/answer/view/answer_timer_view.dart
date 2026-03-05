import 'dart:async';
import 'package:falletter_mobile_v2/core/components/progress/circle_progress.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/answer_provider.dart';
import 'package:falletter_mobile_v2/core/providers/answer_timer_provider.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AnswerTimerView extends ConsumerStatefulWidget {
  final int remainingSeconds;

  const AnswerTimerView({
    super.key,
    required this.remainingSeconds,
  });

  @override
  ConsumerState<AnswerTimerView> createState() => _AnswerTimerViewState();
}

class _AnswerTimerViewState extends ConsumerState<AnswerTimerView> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.remainingSeconds;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        return;
      }

      setState(() {
        _remainingSeconds--;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    final duration = Duration(seconds: _remainingSeconds);
    final totalSeconds = 14400;

    final minutes =
    duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours.toString().padLeft(2, '0');

    final progress = totalSeconds > 0
        ? _remainingSeconds / totalSeconds
        : 0.0;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text('다음 질문까지 남은 시간',
                style: FalletterTextStyle.button.copyWith(
                  color: FalletterColor.gray200,
                )
            ),
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