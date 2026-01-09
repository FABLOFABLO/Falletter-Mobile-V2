import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomGenderButton extends StatelessWidget {
  final String gender;
  final String genderPicture;
  final void Function() onTap;
  final bool isPressed;
  const CustomGenderButton({
    super.key,
    required this.gender,
    required this.genderPicture,
    required this.onTap,
    required this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 31, vertical: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: FalletterColor.middleBlack,
          border: Border.all(color:  isPressed ? FalletterColor.blueGradient.first:FalletterColor.middleBlack,width: 3),
        ),
        child: Column(
          children: [
            SvgPicture.asset(genderPicture),
            Text(gender, style: FalletterTextStyle.title2),
          ],
        ),
      ),
    );
  }
}
