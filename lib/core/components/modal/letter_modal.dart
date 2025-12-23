import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class LetterModal extends ConsumerWidget {
  final String dear;
  final String content;
  final String bottom;

  const LetterModal({
    super.key,
    required this.dear,
    required this.content,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    final closeButtonSize = MediaQuery.of(context).size.width * 0.13;
    const height = SizedBox(height: 12);
    const divider = Divider(color: FalletterColor.gray100, height: 1);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: themeColors.letterModalBorder,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: FalletterColor.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      dear,
                      style: FalletterTextStyle.body3.copyWith(
                        color: FalletterColor.gray800,
                      ),
                    ),
                  ),
                  height,
                  divider,
                  height,
                  Center(
                    child: Text(
                      content,
                      style: FalletterTextStyle.body3.copyWith(
                        color: FalletterColor.middleBlack,
                      ),
                    ),
                  ),
                  height,
                  divider,
                  height,
                  Center(
                    child: Text(
                      bottom,
                      style: FalletterTextStyle.body3.copyWith(
                        color: FalletterColor.gray800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: closeButtonSize,
                height: closeButtonSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: FalletterColor.gray900,
                ),
                child: const Icon(
                  Symbols.close,
                  color: FalletterColor.gray100,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
