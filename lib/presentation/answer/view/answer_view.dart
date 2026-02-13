import 'dart:async';
import 'package:falletter_mobile_v2/core/providers/answer_provider.dart';
import 'package:falletter_mobile_v2/presentation/answer/view/question_view.dart';
import 'package:falletter_mobile_v2/presentation/answer/view/timer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FalletterAnswerView extends ConsumerStatefulWidget {
  const FalletterAnswerView({super.key});

  @override
  ConsumerState<FalletterAnswerView> createState() =>
      _FalletterAnswerViewState();
}

class _FalletterAnswerViewState extends ConsumerState<FalletterAnswerView> {
  Duration countdown = const Duration(hours: 4);
  Duration initialCountdown = const Duration(hours: 4);
  Timer? timer;

  void goNext() {

    final current = ref.read(currentIndexProvider);
    final total = ref.read(totalProvider);

    if (current + 1 < total) {
      ref.read(currentIndexProvider.notifier).state++;
      ref.read(selectedIndexProvider.notifier).state = null;
    } else {
      ref.read(answerStateProvider.notifier).state = AnswerState.waiting;
      startCountdown();
    }
  }

  void startCountdown() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.inSeconds > 0) {
        setState(() {
          countdown -= const Duration(seconds: 1);
        });
      } else {
        timer.cancel();

        ref.read(answerStateProvider.notifier).state = AnswerState.answering;
        ref.read(currentIndexProvider.notifier).state = 0;
        ref.read(selectedIndexProvider.notifier).state = null;

        setState(() {
          countdown = initialCountdown;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final answerState = ref.watch(answerStateProvider);

    return SafeArea(
      child: Scaffold(
        body: answerState == AnswerState.waiting
            ? TimerView(countdown: countdown, initialCountdown: initialCountdown)
            : QuestionView(goNext: goNext)
      ),
    );
  }
}
