import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
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
    final divider = Divider(color: context.middleColor, height: 1);

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
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.cardBg,
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
                          color: context.middleColor,
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
                          color: context.textColor,
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
                          color: context.middleColor,
                        ),
                      ),
                    ),
                  ],
                ),
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
                  color: context.bgColor,
                ),
                child: Icon(
                  Symbols.close,
                  color: context.textColor,
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
