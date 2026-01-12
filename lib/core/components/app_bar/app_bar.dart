import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';

enum Action { brick, letter, order }

class IndexAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool icon;
  final String? title;
  final Action action;
  final int? count;

  const IndexAppBar({
    super.key,
    required this.icon,
    this.title,
    this.count,
    required this.action,
  });

  final String brick = 'assets/svg/brick/brick_blue.svg';
  final String letter = 'assets/svg/letter/letter_blue.svg';

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                Action.brick => Row(
                  children: [
                    SvgPicture.asset(brick, height: 38, width: 36),
                    const SizedBox(width: 12),
                    Text('$count개', style: FalletterTextStyle.body1),
                  ],
                ),
                Action.letter => Row(
                  children: [
                    SvgPicture.asset(letter, height: 42, width: 40),
                    const SizedBox(width: 12),
                    Text('$count개', style: FalletterTextStyle.body1),
                  ],
                ),
                Action.order => Text(
                  '$count/5',
                  style: FalletterTextStyle.body1,
                ),
              },
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
