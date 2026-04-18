import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/components/modal/letter_modal.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/features/user/presentation/provider/student_provider.dart';
import 'package:falletter_mobile_v2/features/letter/presentation/provider/send_letter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:falletter_mobile_v2/core/utils/date_time.dart';

class SendLetterView extends ConsumerStatefulWidget {
  const SendLetterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SendLetterViewState();
}

class _SendLetterViewState extends ConsumerState<SendLetterView> {
  static final double spacing = 20;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(sendLetterProvider.notifier).getSendLetters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final students = ref.watch(studentProvider);
    final letters = ref.watch(sendLetterProvider);
    final reversedLetters = letters.reversed.toList();

    return Scaffold(
      appBar: CustomAppBar(icon: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: spacing),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing),
            child: Text('내가 보낸 레터', style: FalletterTextStyle.title2),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: reversedLetters.length,
              itemBuilder: (BuildContext context, int index) {
                final letter = reversedLetters[index];
                final student = students.where(
                      (s) => s.id == letter.receptionId,
                ).isEmpty ? null : students.firstWhere((s) => s.id == letter.receptionId);
                return ContentCardButton(
                  width: double.infinity,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LetterModal(
                          dear: 'dear',
                          content: letter.content,
                          bottom: sendLetterFormatDateTime(letter.createdAt),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sendLetterFormatDateTime(letter.createdAt),
                          style: FalletterTextStyle.body3.copyWith(
                            color: FalletterColor.gray400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                student != null
                                    ? '${student.schoolNumber} ${student.name}에게'
                                    : '알 수 없는 사용자',
                                style: FalletterTextStyle.subTitle2,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
