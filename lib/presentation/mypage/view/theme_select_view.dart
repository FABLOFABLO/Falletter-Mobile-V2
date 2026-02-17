import 'package:falletter_mobile_v2/core/components/app_bar/custom_app_bar.dart';
import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/components/button/selectable_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ThemeSelectView extends ConsumerStatefulWidget {
  const ThemeSelectView({super.key});

  @override
  ConsumerState<ThemeSelectView> createState() => _ThemeSelectViewState();
}

class _ThemeSelectViewState extends ConsumerState<ThemeSelectView> {
  static final double cardBetween = 24;
  late AppTheme _appTheme = ref.read(themeProvider);

  void _selectTheme(AppTheme value) {
    setState(() {
      _appTheme = value;
    });
  }

  final List<AppTheme> appThemes = [
    AppTheme.blue,
    AppTheme.pink,
    AppTheme.purple,
  ];

  @override
  Widget build(BuildContext context) {
    final themeColor = ref.watch(themeProvider);
    final bool sameTheme = themeColor == _appTheme;
    return Scaffold(
      appBar: CustomAppBar(icon: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text('테마 설정', style: FalletterTextStyle.title2),
              SizedBox(height: cardBetween),
              Wrap(
                spacing: cardBetween,
                runSpacing: cardBetween,
                children: [
                  themeButton(
                    'BLUE',
                    _appTheme == AppTheme.blue,
                    () {
                      _selectTheme(AppTheme.blue);
                    },
                    FalletterGradient.horizontal(FalletterColor.blueGradient),
                  ),
                  themeButton(
                    'PINK',
                    _appTheme == AppTheme.pink,
                    () {
                      _selectTheme(AppTheme.pink);
                    },
                    FalletterGradient.horizontal(FalletterColor.pinkGradient),
                  ),
                  themeButton(
                    'PURPLE',
                    _appTheme == AppTheme.purple,
                    () {
                      _selectTheme(AppTheme.purple);
                    },
                    FalletterGradient.horizontal(FalletterColor.purpleGradient),
                  ),
                ],
              ),
              const Spacer(),
              CustomElevatedButton(
                onPressed: sameTheme
                    ? null
                    : () {
                        ref.read(themeProvider.notifier).changeTheme(_appTheme);
                      },
                child: Text('적용하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget themeButton(
    final String label,
    bool isSelected,
    final void Function() onTap,
    final Gradient gradient,
  ) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - cardBetween - 40) / 2,
      child: SelectableButton(
        icon: Symbols.circle,
        iconGradient: gradient,
        label: label,
        isSelected: isSelected,
        onTap: onTap,
      ),
    );
  }
}
