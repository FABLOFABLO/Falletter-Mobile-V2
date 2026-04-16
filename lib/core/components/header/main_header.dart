import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/features/timer/presentation/provider/roulette_timer_provider.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/features/timer/presentation/view/roulette_timer_view.dart';
import 'package:falletter_mobile_v2/features/roulette/presentation/view/roulette_view.dart';
import 'package:falletter_mobile_v2/features/notice/presentation/provider/notice_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class MainHeader extends ConsumerWidget {
  final double width;
  final double height;
  final bool leadingIcon;

  const MainHeader({
    super.key,
    this.width = 36,
    this.height = 36,
    this.leadingIcon = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    final noticeState = ref.watch(noticeListProvider);
    final hasUnreadNotices = noticeState.notices.any((notice) => !notice.isRead);

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          children: [
            if (leadingIcon)
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                  child: Icon(Symbols.close, color: context.textColor, size: 18)
              ),
            Spacer(),
            GestureDetector(
              child: SvgPicture.asset(themeColors.rouletteCheckSvg, width: width, height: height,),
                onTap: () async {
                  await ref.read(rouletteTimerProvider.notifier).loadRouletteTimer();

                  final timer = ref.read(rouletteTimerProvider)!;

                  if (timer.isActive) {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (_, __, ___) => RouletteTimerView(),
                    );
                  } else {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (_, __, ___) => const RouletteView(),
                    );
                  }
                }
            ),
            const SizedBox(width: 10),
            GestureDetector(
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SvgPicture.asset(themeColors.noticeSvg, width: width, height: height,),
                  if (hasUnreadNotices)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: FalletterColor.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              onTap: () {
                if (GoRouterState.of(context).uri.toString() != '/notification') {
                  context.push('/notification');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
