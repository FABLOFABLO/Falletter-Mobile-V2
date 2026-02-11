import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/router/route_paths.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
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

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          children: [
            if (leadingIcon)
              GestureDetector(
                onTap: () {
                  context.go('${RoutePaths.main}');
                },
                  child: Icon(Symbols.close, color: FalletterColor.white, size: 18)
              ),
            Spacer(),
            GestureDetector(
              child: SvgPicture.asset(themeColors.rouletteCheckSvg, width: width, height: height,),
              onTap: () {},
            ),
            const SizedBox(width: 10),
            GestureDetector(
              child: SvgPicture.asset(themeColors.noticeSvg, width: width, height: height,),
              onTap: () {
                context.go('${RoutePaths.main}/notification');
              },
            ),
          ],
        ),
      ),
    );
  }
}
