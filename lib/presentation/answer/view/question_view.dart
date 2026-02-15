import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/answer_provider.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/presentation/answer/components/answer_card_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class QuestionView extends ConsumerWidget {
  final VoidCallback goNext;

  const QuestionView({super.key, required this.goNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    final buttonTextStyle = FalletterTextStyle.button;

    final currentIndex = ref.watch(currentIndexProvider);
    final total = ref.watch(totalProvider);
    final selectedIndex = ref.watch(selectedIndexProvider);
    final questionList = ref.watch(questionListProvider);
    final currentQuestion = questionList[currentIndex];
    final choices = ref.watch(choicesProvider);

    final question = currentQuestion.question;
    final emoji = currentQuestion.emoji;

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
                        color: FalletterColor.middleBlack,
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
              RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text: '${currentIndex + 1}', style: buttonTextStyle),
                        TextSpan(text: '/$total', style: buttonTextStyle.copyWith(color: FalletterColor.gray600))
                      ]
                  )
              )
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
                  color: FalletterColor.middleBlack,
                  borderRadius: BorderRadius.circular(100)
              ),
              child: Center(child: Text('${emoji}', style: TextStyle(fontSize: 100))),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Center(child: Text('${question}', style: FalletterTextStyle.title2)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < choices.length; i += 2)
                Row(
                  children: [
                    Expanded(
                      child: AnswerCardButton(
                        name: choices[i],
                        isSelected: selectedIndex == i,
                        onTap: () {
                          final selected = ref.read(selectedIndexProvider);
                          if (selected != null) return;

                          ref.read(selectedIndexProvider.notifier).state = i;

                          Future.delayed(
                            const Duration(milliseconds: 700),
                            goNext,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: AnswerCardButton(
                        name: choices[i + 1],
                        isSelected: selectedIndex == i + 1,
                        onTap: () {
                          final selected = ref.read(selectedIndexProvider);
                          if (selected != null) return;

                          ref.read(selectedIndexProvider.notifier).state = i + 1;

                          Future.delayed(
                            const Duration(milliseconds: 700),
                            goNext,
                          );
                        },
                      ),
                    ),
                  ],
                ),
            ],
          )
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: GestureDetector(
            onTap: goNext,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('건너뛰기',
                    style: FalletterTextStyle.body3.copyWith(
                        color: FalletterColor.gray300)
                ),
                Icon(Symbols.double_arrow, color: FalletterColor.gray300, size: 12)
              ],
            ),
          ),
        )
      ],
    );
  }
}
