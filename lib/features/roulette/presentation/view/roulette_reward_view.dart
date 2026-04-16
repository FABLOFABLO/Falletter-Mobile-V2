import 'dart:ui';

import 'package:falletter_mobile_v2/core/components/gradient_text.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/features/roulette/presentation/provider/roulette_provider.dart';
import 'package:falletter_mobile_v2/features/timer/presentation/provider/roulette_timer_provider.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RouletteRewardView extends ConsumerStatefulWidget {
  final RewardType type;
  final int amount;

  const RouletteRewardView({
    super.key,
    required this.type,
    required this.amount,
  });

  @override
  ConsumerState<RouletteRewardView> createState() => _RouletteRewardViewState();
}

class _RouletteRewardViewState extends ConsumerState<RouletteRewardView> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final themeColors = appThemeColors[theme]!;

    String rewardName;
    String? iconPath;
    String titleText;

    if (widget.type == RewardType.brick) {
      rewardName = '브릭';
      iconPath = themeColors.brickSvg;
      titleText = '$rewardName ${widget.amount}개 획득';
    } else if (widget.type == RewardType.letter) {
      rewardName = '레터';
      iconPath = themeColors.letterSvg;
      titleText = '$rewardName ${widget.amount}개 획득';
    } else if (widget.type == RewardType.miss) {
      rewardName = '꽝';
      iconPath = themeColors.missSvg;
      titleText = '$rewardName! 다음에...';
    } else {
      rewardName = '선물세트';
      iconPath = themeColors.rewardSetSvg;
      titleText = '$rewardName 획득';
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(color: context.bgColor.withAlpha(204)),
            ),
          ),
          SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(iconPath),
                if (widget.amount > 1 && widget.type != RewardType.rewardSet)
                  Positioned(
                    right: 80,
                    bottom: 300,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: context.reverseMiddleColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          'X${widget.amount}',
                          style: FalletterTextStyle.title2.copyWith(
                            color: context.reverseTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '출석체크 보상',
                          style: FalletterTextStyle.title3.copyWith(
                            color: context.textColor,
                          ),
                        ),
                        GradientText(
                          text: titleText,
                          gradient: themeColors.primaryGradient,
                          style: FalletterTextStyle.title1,
                        ),
                        SizedBox(height: 330),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: GestureDetector(
                            onTap: () {
                              ref
                                  .read(rouletteTimerProvider.notifier)
                                  .startRouletteTimer();
                              context.go(RoutePaths.main);
                            },
                            child: Text(
                              '닫기',
                              style: FalletterTextStyle.subTitle2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
