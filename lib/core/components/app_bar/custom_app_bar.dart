import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';

enum AppBarAction { brickCount, letterCount, orderStep }

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool icon;
  final String? title;
  final AppBarAction? appBarAction;
  final int? count;

  const CustomAppBar({
    super.key,
    required this.icon,
    this.title,
    this.count,
    this.appBarAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    const double width = 12;
    const double paddingWidth = 20;

    return AppBar(
      toolbarHeight: 40,
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: FalletterColor.black,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: icon == true
              ? Icon(
                  Symbols.keyboard_arrow_left,
                  size: 24,
                  color: FalletterColor.white,
                )
              : null,
        ),
      ),
      title: Text(title ?? '', style: FalletterTextStyle.body1),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
          child: Row(
            children: [
              switch (appBarAction) {
                AppBarAction.brickCount => Row(
                  children: [
                    SvgPicture.asset(
                      themeColors.brickSvg,
                      height: 38,
                      width: 36,
                    ),
                    SizedBox(width: width),
                    Text('$count개', style: FalletterTextStyle.body1),
                  ],
                ),
                AppBarAction.letterCount => Row(
                  children: [
                    SvgPicture.asset(
                      themeColors.letterSvg,
                      height: 24,
                      width: 35,
                    ),
                    const SizedBox(width: width),
                    Text('$count개', style: FalletterTextStyle.body1),
                  ],
                ),
                Action.orderStep => RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: '$count', style: FalletterTextStyle.body1),
                      TextSpan(
                        text: '/5',
                        style: FalletterTextStyle.body1.copyWith(
                          color: FalletterColor.gray700,
                        ),
                      ),
                    ],
                  ),
                ),
                null => const SizedBox.shrink(),
              },
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
