import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class SendLetterModal extends ConsumerStatefulWidget {
  final String sendName;

  const SendLetterModal({super.key, required this.sendName});

  @override
  ConsumerState<SendLetterModal> createState() => _SendLetterModalState();
}

class _SendLetterModalState extends ConsumerState<SendLetterModal>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${widget.sendName}에게\n레터를 전송할게요.',
            style: FalletterTextStyle.body1,
          ),
          Lottie.asset(
            themeColors.sendLetterLottie,
            controller: _animationController,
            fit: BoxFit.cover,
            onLoaded: (onLoaded) {
              _animationController.duration = onLoaded.duration;
              _animationController.forward().then((_) {
                Navigator.of(context).pop();
                context.go(RoutePaths.main);
              });
            },
          ),
          Text(
            '레터는 지금부터 12시간 후에 도착합니다.',
            style: FalletterTextStyle.body3.copyWith(
              color: FalletterColor.gray200,
            ),
          ),
        ],
      ),
    );
  }
}
