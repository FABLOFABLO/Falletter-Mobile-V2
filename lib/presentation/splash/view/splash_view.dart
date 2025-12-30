import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/gradient_text.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/presentation/signup/view/gender_view.dart';
import 'package:falletter_mobile_v2/presentation/splash/provider/auth_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authStatusProvider);
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    return Scaffold(
      body: auth.when(
        data: (status) {
          final isLoggedIn = status == AuthStatus.logIn;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: SvgPicture.asset(themeColors.onBoardingSvg)),

                if (!isLoggedIn) ...{
                  Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '아직 계정이 없으신가요?  ',
                          style: FalletterTextStyle.body3.copyWith(
                            color: FalletterColor.gray400,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SetGenderView(),
                              ),
                            );
                          },
                          child: Text('회원가입', style: FalletterTextStyle.body3),
                        ),
                      ],
                    ),
                  ),
                  CustomElevatedButton(
                    child: GradientText(
                      text: '로그인하기',
                      gradient: themeColors.text,
                      style: FalletterTextStyle.button,
                    ),
                  ),
                  const SizedBox(height: 50,),
                }
              ],
            ),
          );
        },
        error: (error, stack) => Center(
          child: Text(
            '에러 발생\n$error',
            style: FalletterTextStyle.label.copyWith(
              color: FalletterColor.white,
            ),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: FalletterColor.white),
        ),
      ),
    );
  }
}
