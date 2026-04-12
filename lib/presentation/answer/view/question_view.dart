import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/answer_provider.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/presentation/answer/components/answer_card_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class QuestionView extends ConsumerStatefulWidget {
  final VoidCallback goNext;

  const QuestionView({super.key, required this.goNext});

  @override
  ConsumerState<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends ConsumerState<QuestionView> {
  void _onTap(WidgetRef ref, int index, VoidCallback goNext) async {
    final selected = ref.read(selectedIndexProvider);
    final quiz = ref.read(quizProvider);
    if (selected != null || quiz == null) return;
    ref.read(selectedIndexProvider.notifier).state = index;

    try {
      await ref
          .read(quizProvider.notifier)
          .saveAnswer(quiz.question.id, quiz.choices[index].id);

      await Future.delayed(const Duration(milliseconds: 700), goNext);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '답변 저장에 실패했습니다.\n다시 시도해주세요.',
            style: TextStyle(color: FalletterColor.error),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: context.cardBg,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(quizProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    final buttonTextStyle = FalletterTextStyle.button;

    final currentIndex = ref.watch(currentIndexProvider);
    const total = 5;
    final selectedIndex = ref.watch(selectedIndexProvider);
    final quiz = ref.watch(quizProvider);

    if (quiz == null) {
      return SizedBox();
    }

    return Column(
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
          padding: const EdgeInsets.only(top: 30),
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
                  quiz.question.emoji,
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
                quiz.question.question,
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
                        name: quiz.choices[index].name,
                        isSelected: selectedIndex == index,
                        onTap: () => _onTap(ref, index, widget.goNext),
                      ),
                    ),
                    Expanded(
                      child: AnswerCardButton(
                        name: quiz.choices[index + 1].name,
                        isSelected: selectedIndex == index + 1,
                        onTap: () => _onTap(ref, index + 1, widget.goNext),
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
            onTap: widget.goNext,
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
    );
  }
}
