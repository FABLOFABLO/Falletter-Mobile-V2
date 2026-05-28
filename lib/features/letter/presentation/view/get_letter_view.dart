import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/content_card_button.dart';
import 'package:falletter_mobile_v2/core/components/modal/letter_modal.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/utils/date_time.dart';
import 'package:falletter_mobile_v2/features/letter/presentation/provider/get_letter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetLetterView extends ConsumerStatefulWidget {
  const GetLetterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetLetterViewState();
}

class _GetLetterViewState extends ConsumerState<GetLetterView> {
  static final double spacing = 20;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getLetterProvider.notifier).getLetterList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final letters = ref.watch(getLetterProvider);
    final reversed = letters.reversed.where((l) => l.isDelivered).toList();
    return Scaffold(
      appBar: CustomAppBar(icon: true),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: spacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: spacing),
              child: Text('내가 받은 레터', style: FalletterTextStyle.title2),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: reversed.length,
                itemBuilder: (BuildContext context, int idx) {
                  final letter = reversed[idx];
                  return ContentCardButton(
                    width: double.infinity,
                    height: null,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return LetterModal(
                            dear: 'dear',
                            content: letter.content,
                            bottom: '누군가 보냄',
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
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                getLetterFormatDateTime(letter.createdAt),
                                style: FalletterTextStyle.subTitle2,
                              ),
                            ],
                          ),
                          Text(
                            letter.content,
                            style: FalletterTextStyle.body4.copyWith(
                              color: FalletterColor.gray500,
                            ),
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
      ),
    );
  }
}
