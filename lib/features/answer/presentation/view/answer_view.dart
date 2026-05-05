import 'dart:async';
import 'package:falletter_mobile_v2/core/components/progress/loading_circular_indicator.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/features/timer/presentation/provider/answer_timer_provider.dart';
import 'package:falletter_mobile_v2/features/timer/presentation/view/answer_timer_view.dart';
import 'package:falletter_mobile_v2/features/answer/presentation/view/question_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FalletterAnswerView extends ConsumerStatefulWidget {
  const FalletterAnswerView({super.key});

  @override
  ConsumerState<FalletterAnswerView> createState() => _FalletterAnswerViewState();
}

class _FalletterAnswerViewState extends ConsumerState<FalletterAnswerView> {

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
        color: context.bgColor,
        child: loadingCircularIndicator(ref)
      );
    }
    return SafeArea(
      child: Scaffold(
        body: timer.isActive
            ? AnswerTimerView()
            : QuestionView()
      ),
    );
  }
}
