import 'package:falletter_mobile_v2/core/components/gradient_icon.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Gradient gradient;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSelected
                ? CustomGradientIcon(
              icon: icon,
              gradient: gradient,
              fill: 1,
            )
                : Icon(
              icon,
              color: FalletterColor.gray700,
              fill: 1,
            ),
            const SizedBox(height: 4),
            isSelected
                ? ShaderMask(
              shaderCallback: (bounds) =>
                  gradient.createShader(bounds),
              child: Text(
                label,
                style: FalletterTextStyle.body3.copyWith(
                  color: Colors.white,
                ),
              ),
            )
                : Text(
              label,
              style: FalletterTextStyle.body3.copyWith(
                color: FalletterColor.gray700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}