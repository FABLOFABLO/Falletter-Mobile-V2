import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/icon/field_icon.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field_label.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/auth_status_provider.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/features/user/presentation/provider/student_provider.dart';
import 'package:falletter_mobile_v2/features/auth/presentation/provider/sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SigninView extends ConsumerStatefulWidget {
  const SigninView({super.key});

  @override
  ConsumerState<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends ConsumerState<SigninView> {
  final baseStyle = FalletterTextStyle.body3;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool pwObsText = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _emailController.addListener(enabled);
    _passwordController.addListener(enabled);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  static const SizedBox spacing = SizedBox(height: 32);
  static const SizedBox smallSpacing = SizedBox(height: 8);

  void enabled() {
    ref.read(signInProvider.notifier).enabledButton(_emailController.text.trim(), _passwordController.text);
  }

  Widget pwCheck() {
    return pwObsText
        ? FieldIcon.hidePwIcon(onPressed: toggle)
        : FieldIcon.showPwIcon(onPressed: toggle);
  }

  void toggle() {
    setState(() {
      pwObsText = !pwObsText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = ref.watch(
      signInProvider.select((enabled) => enabled.isValid),
    );
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                spacing,
                Text('로그인하고\n팔레터 사용하기', style: FalletterTextStyle.title2),
                const SizedBox(height: 40),
                CustomTextFormFieldLabel(labelText: '이메일', labelStyle: TextStyle(color: context.textColor)),
                smallSpacing,
                CustomTextFormField(
                  controller: _emailController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: '이메일을 입력해주세요.',
                    suffixIconConstraints: const BoxConstraints(minWidth: 60),
                    suffixIcon: FieldIcon.emailText(),
                  ),
                ),
                spacing,
                CustomTextFormFieldLabel(labelText: '비밀번호', labelStyle: TextStyle(color: context.textColor)),
                smallSpacing,
                CustomTextFormField(
                  maxLines: 1,
                  obscureText: pwObsText,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력해주세요.',
                    suffixIcon: pwCheck(),
                  ),
                ),
                smallSpacing,
                Text(errorMessage, style: FalletterTextStyle.body2.copyWith(color: FalletterColor.error)
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '아직 계정이 없으신가요?  ',
                      style: baseStyle.copyWith(color: FalletterColor.gray700),
                    ),
                    smallSpacing,
                    GestureDetector(
                      onTap: () {
                        context.push(RoutePaths.gender);
                      },
                      child: Text('회원가입', style: baseStyle),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomElevatedButton(
                    onPressed: isEnabled
                        ? () async {
                      final success = await ref.read(signInProvider.notifier).signIn(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim()
                      );
                      if (success) {
                        final user = await ref.read(userApiService).getUserInfo();
                        final theme = AppThemeParser.fromString(user.theme);
                        ref.read(themeProvider.notifier).changeTheme(theme);
                        context.go(RoutePaths.main);
                      } else {
                        setState(() {
                          errorMessage = '이메일 또는 비밀번호가 일치하지 않습니다.';
                        });
                      }
                    }
                        : null,
                    child: Text('로그인하기', style: TextStyle(color: context.reverseTextColor)),
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