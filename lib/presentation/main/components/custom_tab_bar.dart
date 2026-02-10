import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTabBar extends ConsumerWidget {
  final List<Tab> tabs;
  final TabController controller;
  const CustomTabBar({super.key, required this.tabs, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TabBar(
        padding: const EdgeInsets.only(left: 20),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        labelColor: themeColors.primaryColor,
        indicatorColor: themeColors.primaryColor,
        unselectedLabelColor: FalletterColor.white,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: tabs,
        controller: controller,
      ),
    );
  }
}
