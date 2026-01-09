import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class IndexAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Icon? icon;
  final int index;

  const IndexAppBar({super.key, this.icon, required this.index});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: FalletterColor.black,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(Symbols.arrow_back_ios, color: FalletterColor.white),
        ),
      ),
      leadingWidth: 24,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '$index', style: FalletterTextStyle.body1),
                TextSpan(
                  text: '/5',
                  style: FalletterTextStyle.body1.copyWith(
                    color: FalletterColor.gray700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
