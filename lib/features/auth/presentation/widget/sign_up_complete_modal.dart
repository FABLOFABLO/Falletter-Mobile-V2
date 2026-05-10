import 'dart:ui';

import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class SignUpCompleteModal extends ConsumerStatefulWidget {
  const SignUpCompleteModal({super.key});

  @override
  ConsumerState<SignUpCompleteModal> createState() =>
      _SignUpCompleteModalState();
}

class _SignUpCompleteModalState extends ConsumerState<SignUpCompleteModal>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);

    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 3));

      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Lottie.asset(
            themeColors.signupLottie,
            controller: _animationController,
            repeat: false,
            onLoaded: (composition) {
              _animationController.duration = composition.duration;
              _animationController.forward();
            },
          ),
      
          Align(
            alignment: Alignment(0, -0.7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('가입 완료!', style: FalletterTextStyle.subTitle2),
                const SizedBox(height: 8),
                Text('팔레터를 사용해보세요', style: FalletterTextStyle.title2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
