import 'dart:async';
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
  Timer? timer;
  int limitTime = 300;
  bool isPressed = false;
  TextEditingController verifyController = TextEditingController();
  bool? verifyResult;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTime();
    });
  }

  void _startTime() {
    if (mounted) {
      timer?.cancel();
    }
    ref.read(signUpProvider.notifier).setTimer(Duration(seconds: limitTime));
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (limitTime > 0) {
        setState(() {
          limitTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String get time {
    Duration duration = Duration(seconds: limitTime);
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    verifyController.dispose();
    super.dispose();
  }

  final reSend = Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: FalletterColor.blueGradient.first,
    ),
    child: Text(
      '재전송',
      style: FalletterTextStyle.placeholder.copyWith(
        color: FalletterColor.black,
      ),
    ),
  );

  void _writeVerifyCode(WidgetRef ref, bool value) {
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
        style: FalletterTextStyle.body2.copyWith(color: FalletterColor.error),
        textAlign: TextAlign.center,
      );
    }
    if (verifyResult == true) {
      return Text(
        '인증이 완료되었습니다',
        style: FalletterTextStyle.body2.copyWith(color: Colors.blue),
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
                style: FalletterTextStyle.body3.copyWith(
                  color: FalletterColor.gray400,
                ),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      onChanged: (value) {
                        _writeVerifyCode(ref, false);
                      },
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      controller: verifyController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        enabled: limitTime > 0,
                        hintText: '인증번호를 입력해주세요',
                        suffixIconConstraints: BoxConstraints(
                          minHeight: 0,
                          minWidth: 0,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Text(
                            time,
                            style: FalletterTextStyle.body3.copyWith(
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
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
                children: [
                  _errorValid() ?? SizedBox.shrink(),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('만약 인증번호가 오지 않으셨나요?', style: FalletterTextStyle.body3),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _check();
                        limitTime = 300;
                        verifyController.clear();
                      });
                    },
                    child: Text(
                      '재전송',
                      style: FalletterTextStyle.body3.copyWith(
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
