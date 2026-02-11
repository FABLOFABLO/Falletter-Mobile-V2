import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/signup/provider/signup_provider.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchoolNumberView extends ConsumerStatefulWidget {
  const SchoolNumberView({super.key});

  @override
  ConsumerState<SchoolNumberView> createState() => _SchoolNumberViewState();
}

class _SchoolNumberViewState extends ConsumerState<SchoolNumberView> {
  final TextEditingController schoolNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void _writeNumber(String value) {
    ref.read(signUpProvider.notifier).setSchoolNumber(value);
  }

  void _writeName(String value) {
    ref.read(signUpProvider.notifier).setName(value);
  }

  @override
  void dispose() {
    schoolNumberController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNextStep = ref.watch(
      signUpProvider.select((enabled) {
        final schoolNumber = (enabled.schoolNumber?.length ?? 0) >= 4;
        final name = (enabled.name?.length ?? 0) >= 3;
        return schoolNumber && name;
      }),
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(icon: true, action: Action.orderStep, count: 2),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                Text('학번 및 이름을 입력해주세요', style: FalletterTextStyle.title2),
                const SizedBox(height: 36),
                CustomTextFormField(
                  maxLength: 4,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: schoolNumberController,
                  onChanged: (value) {
                    _writeNumber(value);
                  },
                  decoration: InputDecoration(
                    hintText: '학번을 입력하세요',
                    counterText: '',
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]')),
                  ],
                  onChanged: (value) {
                    _writeName(value);
                  },
                  controller: nameController,
                  decoration: InputDecoration(hintText: '이름을 입력해주세요'),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CustomElevatedButton(
                    onPressed: isNextStep ? () {} : null,
                    width: double.infinity,
                    child: Text('다음'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
