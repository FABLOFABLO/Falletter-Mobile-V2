import 'package:falletter_mobile_v2/core/components/button/elevated_button.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';

class DefaultModal extends StatelessWidget {
  final String title;
  final String description;
  final String leftButton;
  final String rightButton;
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;

  const DefaultModal({
    super.key,
    required this.title,
    required this.description,
    required this.leftButton,
    required this.rightButton,
    required this.onLeftPressed,
    required this.onRightPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: FalletterColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: FalletterTextStyle.subTitle2.copyWith(
                color: FalletterColor.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: FalletterTextStyle.body3.copyWith(
                color: FalletterColor.gray700,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: onLeftPressed,
                    gradient: const LinearGradient(
                      colors: [FalletterColor.gray200, FalletterColor.gray200],
                    ),
                    textColor: FalletterColor.gray700,
                    child: Text(leftButton),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: onRightPressed,
                    gradient: const LinearGradient(
                      colors: [FalletterColor.error, FalletterColor.error],
                    ),
                    textColor: FalletterColor.white,
                    child: Text(rightButton),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
