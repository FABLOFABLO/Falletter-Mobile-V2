import 'package:falletter_mobile_v2/core/components/button/theme_toggle_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class MyContainer extends ConsumerWidget {
  final String name;
  final int day;
  final String image;

  const MyContainer({
    super.key,
    required this.name,
    required this.day,
    required this.image,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorsProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: FalletterColor.middleBlack,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (image.isNotEmpty)
            Image.network(image)
          else
            Container(
              decoration: BoxDecoration(
                gradient: themeColor.profile,
                shape: BoxShape.circle,
              ),
              width: 52,
              height: 52,
            ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: FalletterTextStyle.title3.copyWith(
                  color: FalletterColor.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '$day일 연속 출석 중',
                style: FalletterTextStyle.body3.copyWith(
                  color: FalletterColor.gray400,
                ),
              ),
            ],
          ),
          const Spacer(),
          ThemeToggleButton(),
        ],
      ),
    );
  }
}
