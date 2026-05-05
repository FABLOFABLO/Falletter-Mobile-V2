import 'package:falletter_mobile_v2/core/components/progress/loading_circular_indicator.dart';
import 'package:falletter_mobile_v2/core/components/snack_bar/snack_bar.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/features/answer/presentation/provider/answer_provider.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/features/answer/presentation/provider/progress_provider.dart';
import 'package:falletter_mobile_v2/features/answer/presentation/widget/answer_card_button.dart';
import 'package:falletter_mobile_v2/features/timer/presentation/provider/answer_timer_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class QuestionView extends ConsumerStatefulWidget {

  const QuestionView({super.key});

  @override
  ConsumerState<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends ConsumerState<QuestionView> {
  void _onTap(WidgetRef ref, int index) async {
    final selected = ref.read(selectedIndexProvider);
    final question = ref.read(currentQuestionProvider);
    final choicesAsync = ref.read(currentChoicesProvider);
    final choices = choicesAsync.value ?? [];
    final progressState = ref.read(progressProvider);

    if (selected != null || question == null || !progressState.hasValue) return;

    ref.read(selectedIndexProvider.notifier).state = index;

    try {
      final apiService = ref.read(answerApiServiceProvider);
      await apiService.chooseAnswer(question.id, choices[index].id);
      await Future.delayed(const Duration(milliseconds: 700));
      await goNext();
    } catch (e) {
      errorSnackBar(context, '답변 저장 실패');
    }
  }

  Future<void> goNext() async {
    ref.read(selectedIndexProvider.notifier).state = null;

    await ref.read(progressProvider.notifier).loadProgress();

    final updated = ref.read(progressProvider).value;

    if (updated != null &&
        (updated.isCompleted ||
            updated.currentIndex >= updated.questionIds.length)) {

      await ref.read(progressProvider.notifier).completeProgress();
      ref.read(progressProvider.notifier).reset();

      await ref.read(answerTimerProvider.notifier).startAnswerTimer();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(progressProvider.notifier).loadProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    final buttonTextStyle = FalletterTextStyle.button;

    final selectedIndex = ref.watch(selectedIndexProvider);
    final progress = ref.watch(progressProvider);
    final question = ref.watch(currentQuestionProvider);
    final choicesAsync = ref.read(currentChoicesProvider);
    final choices = choicesAsync.value ?? [];

    if (progress.isLoading) {
      return Center(child: loadingCircularIndicator(ref));
    }

    if (progress.hasError) {
      return const Center(child: Text('progress 에러'));
    }

    if (question == null) {
      return const Center(child: Text('질문이 없습니다'));
    }

    if (choices.length < 4) {
      return const Center(child: Text('선택지가 부족합니다'));
    }

    final currentIndex = progress.value?.currentIndex ?? 0;
    final total = progress.value?.questionIds.length ?? 0;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 15,
                        decoration: BoxDecoration(
                          color: context.cardBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: (currentIndex + 1) / total,
                        child: Container(
                          height: 15,
                          decoration: BoxDecoration(
                            gradient: themeColors.progressIndicator,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${currentIndex + 1}',
                        style: buttonTextStyle.copyWith(color: context.textColor),
                      ),
                      TextSpan(
                        text: '/$total',
                        style: buttonTextStyle.copyWith(
                          color: FalletterColor.gray500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: Center(
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: context.cardBg,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    question.emoji,
                    style: TextStyle(fontSize: 100),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Container(
              width: 250,
              child: Center(
                child: Text(
                  question.question,
                  style: FalletterTextStyle.title2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(2, (i) {
                  final index = i * 2;

                  return Row(
                    children: [
                      Expanded(
                        child: AnswerCardButton(
                          name: choices[index].name,
                          isSelected: selectedIndex == index,
                          onTap: () => _onTap(ref, index),
                        ),
                      ),
                      Expanded(
                        child: AnswerCardButton(
                          name: choices[index + 1].name,
                          isSelected: selectedIndex == index + 1,
                          onTap: () => _onTap(ref, index + 1),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () async {
                await ref.read(progressProvider.notifier).skipProgress();
                await goNext();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('건너뛰기', style: FalletterTextStyle.body3),
                  const Icon(Symbols.double_arrow, size: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
