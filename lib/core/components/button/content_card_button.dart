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
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: width ?? 350,
                height: height ?? 108,
                decoration: BoxDecoration(
                  color: FalletterColor.middleBlack,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: child
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
