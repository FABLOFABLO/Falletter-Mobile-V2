import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuButton extends ConsumerWidget {
  final String title;
  final void Function() onTap;
  final bool? redText;

  const MenuButton({
    super.key,
    required this.title,
    required this.onTap,
    this.redText = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: FalletterColor.middleBlack,
        ),
        width: double.infinity,
        child: Text(
          title,
          style: FalletterTextStyle.button.copyWith(
            color: redText == true
                ? FalletterColor.error
                : FalletterColor.white,
          ),
        ),
      ),
    );
  }
}
