import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/presentation/signup/provider/signup_provider.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class PasswordView extends ConsumerStatefulWidget {
  const PasswordView({super.key});

  @override
  ConsumerState<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends ConsumerState<PasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();
  bool isPressed = false;
  bool pwObsText = true;
  bool pwObsTextCheck = true;

  String? errorValid() {
    if (!isPressed) return null;
    if (_passwordController.text.isEmpty ||
        _passwordCheckController.text.isEmpty) {
      return null;
    }
    if (_passwordController.text !=
        _passwordCheckController.text) {
      return '비밀번호가 일치하지 않습니다.';
    }
    return null;
  }

  void _password(WidgetRef ref, String value) {
    ref.read(signUpProvider.notifier).setPassword(value);
  }

  void _passwordCheck(WidgetRef ref, String value) {
    ref.read(signUpProvider.notifier).setPasswordCheck(value);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordCheckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNextStep = ref.watch(
      signUpProvider.select((enabled) {
        return enabled.password != null &&
            enabled.passwordCheck != null &&
            enabled.password!.isNotEmpty;
      }),
    );
    return Scaffold(
      appBar: CustomAppBar(icon: true, action: Action.orderStep, count: 5),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: ()=>FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                Text('비밀번호를 입력해주세요.', style: FalletterTextStyle.title2),
                const SizedBox(height: 36),
                CustomTextFormField(
                  onChanged: (value) {
                    _password(ref, value);
                  },
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: '새 비밀번호 입력',
                    suffixIcon: _suffixIcon(
                      onTap: () => setState(() => pwObsText = !pwObsText),
                      pwObsText: pwObsText,
                    ),
                  ),
                  obscureText: pwObsText,
                  maxLines: 1,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  onChanged: (value) {
                    _passwordCheck(ref, value);
                  },
                  controller: _passwordCheckController,
                  decoration: InputDecoration(
                    hintText: '비밀번호 재확인',
                    suffixIcon: _suffixIcon(
                      pwObsText: pwObsTextCheck,
                      onTap: () =>
                          setState(() => pwObsTextCheck = !pwObsTextCheck),
                    ),
                    errorText: errorValid(),
                  ),
                  obscureText: pwObsTextCheck,
                  maxLines: 1,
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: CustomElevatedButton(
                    onPressed: isNextStep
                        ? () {
                            setState(() {
                              isPressed = true;
                            });
                            if (errorValid() != null) return;

                            /// todo 이용약관 페이지
                          }
                        : null,
                    width: double.infinity,
                    child: Text('회원가입'),
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

Widget _suffixIcon({required void Function()? onTap, required bool pwObsText}) {
  return GestureDetector(
    onTap: onTap,
    child: Icon(
      pwObsText ? Symbols.visibility_off : Symbols.visibility,
      fill: 1,
    ),
  );
}
