import 'dart:math';

import 'package:falletter_mobile_v2/core/components/button/theme_toggle_button.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class MyContainer extends ConsumerWidget {
  final String name;
  final String image;

  const MyContainer({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorsProvider);
    final normalizedImage = image.trim();
    final isBlockedDefaultImage = normalizedImage.contains(
      '/falletter/profile/default.png',
    );
    final shouldUseFallback = normalizedImage.isEmpty || isBlockedDefaultImage;

    Widget fallbackAvatar() => Container(
      decoration: BoxDecoration(
        gradient: themeColor.profile,
        shape: BoxShape.circle,
      ),
      width: 52,
      height: 52,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.cardBg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (!shouldUseFallback)
            Image.network(
              normalizedImage,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              errorBuilder: (context, e, st) {
                return fallbackAvatar();
              },
            )
          else
            fallbackAvatar(),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: FalletterTextStyle.title3.copyWith(
                  
                ),
                overflow: TextOverflow.ellipsis,
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
