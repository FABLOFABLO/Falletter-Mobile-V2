import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/gradient/gradient_text.dart';
import 'package:falletter_mobile_v2/core/components/progress/loading_progress_indicator.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/features/splash/presentation/provider/slpashFromLogoutProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/providers/auth_status_provider.dart';

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
    final fromLogout = ref.watch(splashFromLogoutProvider);

    if (fromLogout) {
      return _LogoutUI(context, themeColors);
    }

    return Scaffold(
      body: auth.when(
        loading: () {
          return loadingCircularIndicator(ref);
        },
        data: (status) {
          final isLoggedIn = status == AuthStatus.logIn;

          if (isLoggedIn) {
            final init = ref.read(appInitProvider);

            return init.when(
              loading: () => loadingCircularIndicator(ref),

              data: (_) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    context.go(RoutePaths.main);
                  }
                });
                return const SizedBox();
              },

              error: (_, __) {
                return Center(child: Text('초기화 실패'));
              },
            );
          }

          return _LogoutUI(context, themeColors);
        },
        error: (error, stack) {
          return Center(
            child: Text('에러 발생'),
          );
        },
      ),
    );
  }

  Widget _LogoutUI(BuildContext context, themeColors) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SvgPicture.asset(themeColors.onBoardingSvg)),

            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아직 계정이 없으신가요?',
                    style: FalletterTextStyle.body3.copyWith(
                      color: FalletterColor.gray700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/signup/gender'),
                    child: Text('회원가입'),
                  ),
                ],
              ),
            ),

            CustomElevatedButton(
              onPressed: () => context.push('/signin'),
              gradient: LinearGradient(
                colors: [context.cardBg, context.cardBg],
              ),
              child: GradientText(
                text: '로그인하기',
                gradient: themeColors.text,
                style: FalletterTextStyle.button,
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}