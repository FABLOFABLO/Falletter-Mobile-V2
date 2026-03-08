import 'dart:async';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/providers/answer_provider.dart';
import 'package:falletter_mobile_v2/core/providers/answer_timer_provider.dart';
import 'package:falletter_mobile_v2/core/providers/roulette_timer_provider.dart';
import 'package:falletter_mobile_v2/presentation/answer/view/question_view.dart';
import 'package:falletter_mobile_v2/presentation/answer/view/answer_timer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FalletterAnswerView extends ConsumerStatefulWidget {
  const FalletterAnswerView({super.key});

  @override
  ConsumerState<FalletterAnswerView> createState() => _FalletterAnswerViewState();
}

class _FalletterAnswerViewState extends ConsumerState<FalletterAnswerView> {

  void goNext() {

    final current = ref.read(currentIndexProvider);
    const total = 5;

    if (current + 1 < total) {
      ref.read(answerProvider.notifier).nextQuestion();
    } else {
      ref.read(answerTimerProvider.notifier).startAnswerTimer();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(answerTimerProvider.notifier).loadAnswerTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(answerTimerProvider);

    if (timer == null) {
      return Container(
        color: FalletterColor.black,
        child: Center(
            child: CircularProgressIndicator(
              color: FalletterColor.middleBlack,
            )
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: timer!.isActive
            ? AnswerTimerView()
            : QuestionView(goNext: goNext)
      ),
    );
  }
}
