import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/models/letter_model.dart';
import 'package:falletter_mobile_v2/presentation/letter/provider/letter_provider.dart';
import 'package:falletter_mobile_v2/presentation/letter/widget/send_letter_modal.dart';
import 'package:falletter_mobile_v2/presentation/letter/widget/type_ahead.dart';
import 'package:falletter_mobile_v2/presentation/mypage/provider/send_letter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FalletterLetterView extends ConsumerStatefulWidget {
  const FalletterLetterView({super.key});

  @override
  ConsumerState<FalletterLetterView> createState() =>
      _FalletterLetterViewState();
}

class _FalletterLetterViewState extends ConsumerState<FalletterLetterView> {
  static final double titleHeight = 16;
  String? name;
  int? receptionId;
  bool isSending = false;
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _peopleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _enabled() {
    ref
        .read(letterProvider.notifier)
        .valid(
          selectName: name ?? '',
          inputStudent: _peopleController.text,
          content: _contentController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(letterProvider).count;
    final isNextStep = ref.watch(letterProvider).valid;
    final style = FalletterTextStyle.subTitle1;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          icon: false,
          count: count,
          appBarAction: AppBarAction.letterCount,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        Text('누구에게 보내시나요?', style: style),
                        SizedBox(height: titleHeight),
                        TypeAhead(
                          controller: _peopleController,
                          onChanged: _enabled,
                          onSelected: (student) {
                            setState(() {
                              receptionId = student.id;
                              name = '${student.schoolNumber} ${student.name}';
                            });
                            _enabled();
                          },
                        ),
                        SizedBox(height: titleHeight * 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('레터를 작성해주세요', style: style),
                            Text.rich(
                              textAlign: TextAlign.end,
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${_contentController.text.length}',
                                    style: FalletterTextStyle.body2.copyWith(color: context.textColor),
                                  ),
                                  TextSpan(
                                    text: '/200',
                                    style: FalletterTextStyle.body2.copyWith(color: FalletterColor.gray500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: titleHeight),
                        CustomTextFormField(
                          onChanged: (value) {
                            setState(() {});
                            _enabled();
                          },
                          controller: _contentController,
                          maxLength: 200,
                          maxLines: 9,
                          decoration: InputDecoration(
                            enabled: count > 0,
                            counterText: '',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomElevatedButton(
                  width: double.infinity,
                  onPressed: (isNextStep && receptionId != null && !isSending)
                      ? () async {
                          setState(() {
                            isSending = true;
                          });

                          try {
                            final request = LetterModel(
                                content: _contentController.text,
                                receptionId: receptionId!
                            );
                            await ref.read(sendLetterProvider.notifier).sendLetter(request);
                            await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => SendLetterModal(
                                sendName: _peopleController.text,
                              ),
                            );
                            ref.read(letterProvider.notifier).decrease();
                            _peopleController.clear();
                            _contentController.clear();
                            setState(() {
                              name = null;
                            });
                            _enabled();
                          } catch(e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('전송 중 오류가 발생했습니다.'), backgroundColor: FalletterColor.middleBlack,),
                            );
                          } finally {
                            setState(() {
                              isSending = false;
                            });
                          }
                        }
                      : null,
                  child: Text('레터 전송하기'),
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
