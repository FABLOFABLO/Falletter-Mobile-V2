import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/theme/falletter_theme.dart';
import 'package:falletter_mobile_v2/presentation/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashGate extends StatefulWidget {
  final GoRouter router;

  const SplashGate({
    super.key,
    required this.router,
  });

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  bool _showRouter = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 3));

      if (!mounted) return;

      final bool isLoggedIn = await _checkLoginState();

      if (isLoggedIn) {
        setState(() => _showRouter = true);
      }
    });
  }

  Future<bool> _checkLoginState() async {
    // TODO: 실제 로그인 확인 로직 연결 / ex) authRepository.isLoggedIn();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: widget.router,
      theme: ThemeData(
        scaffoldBackgroundColor: FalletterColor.black,
        inputDecorationTheme: inputDecorationTheme,
        textSelectionTheme: textSelectionTheme,
      ),
      builder: (context, child) {
        if (!_showRouter) {
          return const SplashView();
        }
        return child!;
      },
    );
  }
}
