import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/signup/provider/signup_provider.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyCodeView extends ConsumerStatefulWidget {
  const VerifyCodeView({super.key});

  @override
  ConsumerState<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends ConsumerState<VerifyCodeView> {
  final baseStyle = FalletterTextStyle.body3;
  final errorStyle = FalletterTextStyle.body2;
  bool isPressed = false;
  TextEditingController verifyController = TextEditingController();
  bool? verifyResult;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(signUpProvider.notifier).startTime();
    });
  }


  @override
  void dispose() {
    verifyController.dispose();
    super.dispose();
  }

  String durationTime(Duration? duration) {
    final durations = duration;
    return '${durations?.inMinutes.toString().padLeft(2, '0')}:${(durations!.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _writeVerifyCode(bool value) {
    ref.read(signUpProvider.notifier).setVerified(value);
  }

  // 임시코드
  String number = '123456';

  void _check() {
    setState(() {
      isPressed = true;
      verifyResult = (verifyController.text == number);
    });
    if (verifyController.text == number) {
      ref.read(signUpProvider.notifier).setVerified(true);
    }
    if (verifyController.text != number) {
      ref.read(signUpProvider.notifier).setVerified(false);
    }
  }

  Widget? _errorValid() {
    if (!isPressed || verifyResult == null) return null;
    if (verifyResult == false) {
      return Text(
        '인증번호가 일치하지 않습니다',
        style: errorStyle.copyWith(color: FalletterColor.error),
        textAlign: TextAlign.center,
      );
    }
    if (verifyResult == true) {
      return Text(
        '인증이 완료되었습니다',
        style: errorStyle.copyWith(color: Colors.blue),
        textAlign: TextAlign.center,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isNextStep = ref.watch(
      signUpProvider.select((enWrite) {
        return enWrite.verified ?? false;
      }),
    );
    final timer = ref.watch(signUpProvider).timer ?? Duration.zero;
    bool limitTime = timer.inSeconds > 0;
    return Scaffold(
      appBar: CustomAppBar(icon: true, action: Action.orderStep, count: 4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 28),
              Text('인증번호를 입력해주세요.', style: FalletterTextStyle.title2),
              const SizedBox(height: 8),
              Text(
                '입력한 이메일로 전송했어요!',
                style: baseStyle.copyWith(color: FalletterColor.gray400),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _writeVerifyCode(false);
                      },
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      controller: verifyController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        enabled: limitTime,
                        hintText: '인증번호를 입력해주세요',
                        suffixIconConstraints: BoxConstraints(
                          minHeight: 0,
                          minWidth: 0,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Text(
                            durationTime(timer),
                            style: baseStyle.copyWith(
                              color: FalletterColor.error,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: _check,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: FalletterColor.blueGradient.first,
                      ),
                      child: Text(
                        '인증번호 확인',
                        style: FalletterTextStyle.placeholder.copyWith(
                          color: FalletterColor.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [_errorValid() ?? SizedBox.shrink()],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('만약 인증번호가 오지 않으셨나요?', style: baseStyle),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        verifyController.clear();
                        verifyResult = null;
                      });
                      ref.read(signUpProvider.notifier).startTime();
                    },
                    child: Text(
                      '재전송',
                      style: baseStyle.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: FalletterColor.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomElevatedButton(
                onPressed: isNextStep ? () {} : null,
                child: Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
