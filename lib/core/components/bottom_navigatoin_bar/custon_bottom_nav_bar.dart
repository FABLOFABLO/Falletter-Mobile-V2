import 'package:falletter_mobile_v2/core/components/bottom_navigatoin_bar/bottom_navigation_item.dart';
import 'package:falletter_mobile_v2/core/constants/app_theme_color.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _icons = [
    Symbols.home,
    Symbols.mail,
    Symbols.brick,
    Symbols.notifications,
    Symbols.person,
  ];

  static const _labels = ['홈', '레터', '답변', '알림', '마이페이지'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: FalletterColor.black,
          border: Border(
            top: BorderSide(
              color: FalletterColor.gray900,
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_icons.length, (index) {
                final isSelected = currentIndex == index;

                return BottomNavItem(
                  icon: _icons[index],
                  label: _labels[index],
                  isSelected: isSelected,
                  gradient: themeColors.bottomNavIcon,
                  onTap: () => onTap(index),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}