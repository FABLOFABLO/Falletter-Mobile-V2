import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/icon/field_icon.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/signup/provider/signup_provider.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailView extends ConsumerStatefulWidget {
  const EmailView({super.key});

  @override
  ConsumerState<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends ConsumerState<EmailView> {
  final TextEditingController _emailController = TextEditingController();
  final String title = '이메일을 입력해주세요';
  bool isEnabled = false;
  String buttonText = '인증번호 전송';
  final suffixText = Text(
    '@dsm.hs.kr',
    style: FalletterTextStyle.body2.copyWith(color: FalletterColor.gray500),
  );

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _writeEmail(WidgetRef ref, String value) {
    ref.read(signUpProvider.notifier).setEmail(value);
  }

  @override
  Widget build(BuildContext context) {
    final isNextStep = ref.watch(
      signUpProvider.select((enWrite) => enWrite.emailValid()),
    );
    return Scaffold(
      appBar: CustomAppBar(icon: true, action: Action.orderStep, count: 3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              Text(title, style: FalletterTextStyle.title2),
              const SizedBox(height: 36),
              CustomTextFormField(
                controller: _emailController,
                maxLength: 30,
                maxLines: 1,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '이메일을 입력해주세요',
                  suffixIcon: FieldIcon.emailText(),
                ),
                onChanged: (value) {
                  _writeEmail(ref, value);
                },
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
              ),
              const Spacer(),
              CustomElevatedButton(
                onPressed: isNextStep
                    ? () {
                        ref.read(signUpProvider.notifier).setTimer(Duration(seconds: 300));

                        /// 인증 페이지 연결
                      }
                    : null,
                width: double.infinity,
                child: Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
