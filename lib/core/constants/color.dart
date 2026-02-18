import 'package:flutter/painting.dart';

abstract final class FalletterColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF141414);
  static const Color middleBlack = Color(0xFF1C1C1C);
  static const Color error = Color(0xFFFF7A7A);

  static const Color gray50 = Color(0xFFF4F4F4);
  static const Color gray100 = Color(0xFFE4E4E4);
  static const Color lightTheme = Color(0xFFDDDDDD);
  static const Color gray200 = Color(0xFFD0D0D0);
  static const Color gray300 = Color(0xFFBCBCBC);
  static const Color gray400 = Color(0xFFA7A7A7);
  static const Color gray500 = Color(0xFF939393);
  static const Color gray600 = Color(0xFF7E7E7E);
  static const Color gray700 = Color(0xFF6A6A6A);
  static const Color gray800 = Color(0xFF565656);
  static const Color gray900 = Color(0xFF414141);
  static const Color darkTheme = Color(0xFF3D3D3D);

  static const List<Color> blueGradient = [
    Color(0xFF0CDFE6),
    Color(0xFF93AAFF),
  ];
  static const List<Color> pinkGradient = [
    Color(0xFFFF9BBB),
    Color(0xFFFF507F),
  ];
  static const List<Color> purpleGradient = [
    Color(0xFFEC89FF),
    Color(0xFFB640FF),
  ];
}

abstract final class FalletterGradient {
  static LinearGradient horizontal(List<Color> baseColors) {
    return LinearGradient(
      colors: baseColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static LinearGradient vertical(List<Color> baseColors) {
    return LinearGradient(
      colors: baseColors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}
