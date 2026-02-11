import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';

class ContentCardButton extends StatelessWidget {
  final Widget child;
  final void Function() onTap;
  final double? width;
  final double? height;

  const ContentCardButton({
    super.key,
    required this.child,
    required this.onTap,
    this.width,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          width: width ?? double.infinity,
          height: height ?? null,
          decoration: BoxDecoration(
            color: FalletterColor.middleBlack,
            borderRadius: BorderRadius.circular(10),
          ),
          child: child
        ),
      ),
    );
  }
}
