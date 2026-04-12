import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:flutter/material.dart';

void ErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: FalletterColor.error),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: context.cardBg,
      )
  );
}