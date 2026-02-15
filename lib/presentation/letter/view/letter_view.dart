import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/models/student_model.dart';
import 'package:falletter_mobile_v2/presentation/letter/provider/letter_provider.dart';
import 'package:falletter_mobile_v2/presentation/letter/widget/send_letter_modal.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class FalletterLetterView extends ConsumerStatefulWidget {
  const FalletterLetterView({super.key});

  @override
  ConsumerState<FalletterLetterView> createState() =>
      _FalletterLetterViewState();
}

class _FalletterLetterViewState extends ConsumerState<FalletterLetterView> {
  String? name;
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final List<StudentModel> students = [];

  @override
  void initState(){
    super.initState();
    students.addAll(
      [StudentModel(id: 1, schoolNumber: '1216', name: '최승우'),
        StudentModel(id: 1, schoolNumber: '1410', name: '이승현'),
        StudentModel(id: 1, schoolNumber: '3310', name: '유지우'),],
    );
    _peopleController.addListener(enabled);
    _contentController.addListener(enabled);
  }
  @override
  void dispose() {
    _peopleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  static final double titleHeight = 16;
  void enabled(){
    ref.read(letterProvider.notifier).valid(name ?? '', _peopleController.text, _contentController.text);
  }
  @override
  Widget build(BuildContext context) {
    final count = ref.watch(letterProvider).count;
    final isNextStep = ref.watch(letterProvider).valid;
    final style = FalletterTextStyle.subTitle1.copyWith(color: count > 0
        ? FalletterColor.white
        : FalletterColor.gray400);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          icon: false,
          count: count,
          action: Action.letterCount,
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
                        Text(
                          '누구에게 보내시나요?',
                          style: style,
                        ),
                        SizedBox(height: titleHeight),
                        _typeAhead(),
                        SizedBox(height: titleHeight * 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('레터를 작성해주세요', style: style,),
                            RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${_contentController.text.length}',
                                    style: FalletterTextStyle.body2,
                                  ),
                                  TextSpan(
                                    text: '/200',
                                    style: FalletterTextStyle.body2.copyWith(
                                      color: FalletterColor.gray400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: titleHeight),
                        CustomTextFormField(
                          onChanged: (value){
                            setState(() {
                            });
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
                  onPressed: isNextStep
                      ? () async {
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
                          name = null;
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

  Widget _typeAhead() {
    final count = ref.watch(letterProvider).count;
    return TypeAheadField<String>(
      constraints: BoxConstraints(maxHeight: 140),
      controller: _peopleController,
      builder: (context, controller, focusNode) {
        return CustomTextFormField(
          maxLength: 10,
          maxLines: 1,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          controller: _peopleController,
          focusNode: focusNode,
          decoration: InputDecoration(
            enabled: count > 0,
            hintText: '학번을 입력해주세요',
            counterText: '',
          ),
        );
      },
      decorationBuilder: (context, child) {
        return Container(
          decoration: BoxDecoration(color: FalletterColor.middleBlack),
          child: child,
        );
      },
      itemBuilder: (BuildContext context, value) {
        final inputText = _peopleController.text;
        final stressText = value.indexOf(inputText);
        final baseStyle = FalletterTextStyle.body3;
        if (stressText >= 0) {
          return ListTile(
            visualDensity: VisualDensity.compact,
            dense: true,
            title: RichText(
              text: TextSpan(
                style: baseStyle.copyWith(color: FalletterColor.gray400),
                children: [
                  TextSpan(text: value.substring(0, stressText)),
                  TextSpan(
                    text: value.substring(stressText, stressText + inputText.length,),
                    style: baseStyle.copyWith(color: FalletterColor.white),
                  ),
                  TextSpan(
                    text: value.substring(stressText + inputText.length),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
      hideOnEmpty: true,
      onSelected: (value) {
        _peopleController.text = value;
        name = value;
      },
      suggestionsCallback: (patten) async {
        if (patten.isEmpty) {
          return <String>[];
        }
        return students
            .where((students) => students.name.contains(patten) || students.schoolNumber.contains(patten))
            .map((e) => '${e.schoolNumber} ${e.name}')
            .toList();
      },
    );
  }
}
