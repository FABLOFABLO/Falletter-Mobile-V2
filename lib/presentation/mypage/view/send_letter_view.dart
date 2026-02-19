import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/components/modal/letter_modal.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/mypage/provider/send_letter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:falletter_mobile_v2/core/utils/date_time.dart';

class SendLetterView extends ConsumerWidget {
  const SendLetterView({super.key});

  static final double h = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final letter = ref.watch(sendLetterProvider);
    return Scaffold(
      appBar: CustomAppBar(icon: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: h),
            child: Text('내가 보낸 레터', style: FalletterTextStyle.title2),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: letter.length,
              itemBuilder: (BuildContext context, int index) {
                final letters = letter[index];
                return ContentCardButton(
                  width: double.infinity,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LetterModal(
                          dear: '누군가 보냄',
                          content: letters.content,
                          bottom: sendLetterFormatTime(letters.createdAt),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: h, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sendLetterFormatTime(letters.createdAt),
                          style: FalletterTextStyle.subTitle2,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                letters.content,
                                style: FalletterTextStyle.body3.copyWith(
                                  color: FalletterColor.gray400,
                                ),
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
