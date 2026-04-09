import 'package:flutter/material.dart';
import 'color.dart';

extension ColorContextExtension on BuildContext {
  Color get cardBg => FalletterColor.getCardBackground(this);
  Color get textColor => FalletterColor.getTextColor(this);
  Color get bgColor => FalletterColor.getBackgroundColor(this);
  Color get middleColor => FalletterColor.getMiddleColor(this);

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
