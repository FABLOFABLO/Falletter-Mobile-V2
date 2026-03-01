import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/icon/field_icon.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field.dart';
import 'package:falletter_mobile_v2/core/components/text_form_field/text_form_field_label.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/data/auth/auth_repository.dart';
import 'package:falletter_mobile_v2/presentation/signin/provider/sign_in_provider.dart';
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
  String errorText = '';
  bool isLoading = false;

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

  static const double height = 32;
  static const double lowSize = 8;

  void enabled() {
    ref
        .read(signInProvider.notifier)
        .enabledButton(_emailController.text, _passwordController.text);
  }

  Widget pwCheck() {
    return pwObsText
        ? FieldIcon.hidePwIcon(onPressed: stateChange)
        : FieldIcon.showPwIcon(onPressed: stateChange);
  }

  Future<void> _login() async {
    setState(() => errorText = '');
    final rawEmail = _emailController.text.trim();
    final email = rawEmail.contains('@') ? rawEmail : '$rawEmail@dsm.hs.kr';
    final password = _passwordController.text.trim();

    try {
      await ref.read(authRepositoryProvider).signIn(email: email, password: password);
      if (!mounted) return;
      context.go(RoutePaths.main);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorText = '이메일 또는 비밀번호가 일치하지 않습니다.';
      });
    }
  }

  void stateChange() {
    setState(() {
      pwObsText = !pwObsText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = ref.watch(signInProvider.select((s) => s.isValid));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height),
                Text('로그인하고\n팔레터 사용하기', style: FalletterTextStyle.title2),
                const SizedBox(height: 40),
                CustomTextFormFieldLabel(labelText: '이메일'),
                SizedBox(height: lowSize),
                CustomTextFormField(
                  controller: _emailController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: '이메일을 입력해주세요.',
                    suffixIconConstraints: BoxConstraints(minWidth: 60),
                    suffixIcon: FieldIcon.emailText(),
                  ),
                ),
                SizedBox(height: height),
                CustomTextFormFieldLabel(labelText: '비밀번호'),
                SizedBox(height: lowSize),
                CustomTextFormField(
                  maxLines: 1,
                  obscureText: pwObsText,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력해주세요.',
                    suffixIcon: pwCheck(),
                  ),
                ),
                SizedBox(height: lowSize),
                Text(
                  errorText,
                  style: FalletterTextStyle.placeholder.copyWith(
                    color: FalletterColor.error,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '아직 계정이 없으신가요?',
                      style: baseStyle.copyWith(color: FalletterColor.gray400),
                    ),
                    SizedBox(width: lowSize),
                    GestureDetector(
                      onTap: () {
                        /// todo 회원가입 첫 페이지 GoRouter로 이동
                      },
                      child: Text('회원가입', style: baseStyle),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CustomElevatedButton(
                  onPressed: isButtonEnabled ? _login : null,
                  child: Text('로그인하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
