import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/presentation/signup/provider/signup_provider.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      ref.read(signUpProvider.notifier).startTimer();
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

  Future<void> _check() async {
    setState(() {
      isPressed = true;
    });

    final result = await ref.read(signUpProvider.notifier)
        .checkVerifyCode(verifyController.text.trim());

    setState(() {
      verifyResult = result;
    });

    if (result) {
      ref.read(signUpProvider.notifier).stopTimer();
    }

    ref.read(signUpProvider.notifier).setVerified(result);
  }

  Widget? _errorValid() {
    final timer = ref.read(signUpProvider).timer ?? Duration.zero;
    if (timer.inSeconds <= 0) {
      return Text(
        '인증번호가 만료되었습니다',
        style: errorStyle.copyWith(color: FalletterColor.error),
        textAlign: TextAlign.center,
      );
    }
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
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    final isNextStep = ref.watch(
      signUpProvider.select((enWrite) {
        return enWrite.verified ?? false;
      }),
    );
    final timer = ref.watch(signUpProvider).timer ?? Duration.zero;
    bool limitTime = timer.inSeconds > 0;
    return Scaffold(
      appBar: CustomAppBar(icon: true, appBarAction: AppBarAction.orderStep, count: 4),
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
                style: baseStyle,
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
                        enabled: limitTime && !isNextStep,
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
                    onTap: isNextStep ? null : _check,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: themeColors.progressIndicator
                      ),
                      child: Text(
                        '인증번호 확인',
                        style: FalletterTextStyle.placeholder.copyWith(
                          color: context.bgColor,
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
                  Text('인증번호가 오지 않으셨나요?', style: baseStyle),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      if (!isNextStep) {
                        setState(() {
                          verifyController.clear();
                          verifyResult = null;
                        });
                        ref.read(signUpProvider.notifier).startTimer();
                        ref.read(signUpProvider.notifier).sendEmailCode();
                      }
                    },
                    child: Text(
                      '재전송',
                      style: baseStyle.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: context.bgColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomElevatedButton(
                  onPressed: isNextStep ? () {
                      context.push(RoutePaths.password);
                  } : null,
                  child: Text('다음', style: TextStyle(color: context.reverseTextColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
