import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';

enum Action { brickCount, letterCount, orderStep }

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool icon;
  final String? title;
  final Action? action;
  final int? count;

  const CustomAppBar({
    super.key,
    required this.icon,
    this.title,
    this.count,
    this.action,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: AppBar(
          centerTitle: true,
          backgroundColor: FalletterColor.black,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: icon == true
                ? Icon(
                    Symbols.arrow_back_ios,
                    size: 24,
                    color: FalletterColor.white,
                  )
                : null,
          ),
          title: Text(title ?? '', style: FalletterTextStyle.body1),
          leadingWidth: 20,
          actions: [
            Row(
              children: [
                switch (action) {
                  Action.brickCount => Row(
                    children: [
                      SvgPicture.asset(
                        themeColors.brickSvg,
                        height: 38,
                        width: 36,
                      ),
                      const SizedBox(width: 12),
                      Text('$count개', style: FalletterTextStyle.body1),
                    ],
                  ),
                  Action.letterCount => Row(
                    children: [
                      SvgPicture.asset(
                        themeColors.letterSvg,
                        height: 24,
                        width: 35,
                      ),
                      const SizedBox(width: 12),
                      Text('$count개', style: FalletterTextStyle.body1),
                    ],
                  ),
                  Action.orderStep => Text(
                    '$count/5',
                    style: FalletterTextStyle.body1,
                  ),
                  null => const SizedBox.shrink(),
                },
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
