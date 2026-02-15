import 'dart:ui';

import 'package:falletter_mobile_v2/core/components/gradient_text.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/presentation/roulette/components/roulette.dart';
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
    required this.amount
  });

  @override
  ConsumerState<RouletteRewardView> createState() => _RouletteRewardViewState();
}

class _RouletteRewardViewState extends ConsumerState<RouletteRewardView> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final themeColors = appThemeColors[theme]!;
    final isMiss = widget.type == RewardType.miss;

    String rewardName;
    String? iconPath;

    if (widget.type == RewardType.brick) {
      rewardName = '브릭';
      iconPath = themeColors.brickSvg;
    }
    else if (widget.type == RewardType.letter) {
      rewardName = '레터';
      iconPath = themeColors.letterSvg;
    }
    else {
      rewardName = '꽝';
      iconPath = themeColors.missSvg;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: FalletterColor.black.withAlpha(204),
                ),
              ),
            ),
            SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('출석체크 보상',
                            style: FalletterTextStyle.title3.copyWith(
                                color: FalletterColor.white)
                        ),
                        GradientText(
                            text: isMiss
                            ? '$rewardName 획득'
                            : '$rewardName ${widget.amount}개 획득',
                            gradient: themeColors.primaryGradient,
                            style: FalletterTextStyle.title1
                        ),
                        SizedBox(height: 20),
                        if(iconPath != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SvgPicture.asset(
                              iconPath
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: GestureDetector(
                            onTap: () {
                              context.go('${RoutePaths.main}');
                              },
                            child: Text('닫기',
                                style: FalletterTextStyle.subTitle2.copyWith(
                                    color: FalletterColor.gray600
                                )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
          ]
      ),
    );
  }
}
