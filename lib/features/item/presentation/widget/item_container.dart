import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemContainer extends ConsumerWidget {
  final String item;
  final int count;

  const ItemContainer({super.key, required this.item, required this.count});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.cardBg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SvgPicture.asset(item, width: 30, height: 38)),
            const Spacer(),
            Text(
              '$count개',
              style: FalletterTextStyle.body1.copyWith(
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
