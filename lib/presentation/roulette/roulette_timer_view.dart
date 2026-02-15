import 'dart:async';
import 'dart:ui';

import 'package:falletter_mobile_v2/core/components/gradient_text.dart';
import 'package:falletter_mobile_v2/core/components/progress/circle_progress.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RouletteTimerView extends ConsumerStatefulWidget {
  final int remainingSeconds;

  const RouletteTimerView({
    super.key,
    required this.remainingSeconds
  });

  @override
  ConsumerState<RouletteTimerView> createState() => _RouletteTimerViewState();
}

class _RouletteTimerViewState extends ConsumerState<RouletteTimerView> {
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
        if(mounted) {
          context.pop();
        }
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
    final theme = ref.watch(themeProvider);
    final themeColors = appThemeColors[theme]!;

    final duration = Duration(seconds: _remainingSeconds);
    final totalSeconds = 86400;

    final minutes =
    duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours.toString().padLeft(2, '0');

    final progress = totalSeconds > 0
        ? _remainingSeconds / totalSeconds
        : 0.0;

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
            child: Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text('다음 출석체크까지', style: FalletterTextStyle.title3),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                              color: FalletterColor.middleBlack,
                              shape: BoxShape.circle
                          ),
                        ),
                        CustomPaint(
                          size: Size(300, 300),
                          painter: CircleProgress(
                              gradient: themeColors.progressIndicator,
                              progress: progress,
                              strokeWidth: 10
                          ),
                        ),
                        GradientText(
                            text: '$hours:$minutes',
                            gradient: themeColors.primaryGradient,
                            style: FalletterTextStyle.title1.copyWith(
                              fontSize: 40
                            )
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: Text('닫기',
                              style: FalletterTextStyle.subTitle2.copyWith(
                                  color: FalletterColor.gray600
                              )
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
