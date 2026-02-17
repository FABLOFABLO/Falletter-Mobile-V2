import 'dart:async';
import 'package:falletter_mobile_v2/core/providers/answer_provider.dart';
import 'package:falletter_mobile_v2/core/providers/answer_timer_provider.dart';
import 'package:falletter_mobile_v2/presentation/answer/view/question_view.dart';
import 'package:falletter_mobile_v2/presentation/answer/view/timer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FalletterAnswerView extends ConsumerWidget {
  const FalletterAnswerView({super.key});

  void goNext(WidgetRef ref) {

    final current = ref.read(currentIndexProvider);
    const total = 5;

    if (current + 1 < total) {
      ref.read(answerProvider.notifier).nextQuestion();
    } else {
      ref.read(answerStateProvider.notifier).state = AnswerState.waiting;
      ref.read(answerTimerProvider.notifier).startCountdown();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answerState = ref.watch(answerStateProvider);

    return SafeArea(
      child: Scaffold(
        body: answerState == AnswerState.waiting
            ? TimerView()
            : QuestionView(goNext: () => goNext(ref))
      ),
    );
  }
}
