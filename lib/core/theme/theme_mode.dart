import 'package:flutter/material.dart';
import 'package:falletter_mobile_v2/core/constants/color.dart';

InputBorder _lightBorder(Set<WidgetState> states) {
  Color? color = Colors.transparent;

  if (states.contains(WidgetState.focused)) {
    color = FalletterColor.black;
  }

  if (states.contains(WidgetState.error)) {
    color = FalletterColor.error;
  }

  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(width: 1, color: color),
  );
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: FalletterColor.whiteBg,
  primaryColor: const Color(0xFF0CDFE6),
  canvasColor: FalletterColor.middleWhite,
  cardColor: FalletterColor.middleWhite,
  disabledColor: FalletterColor.gray600,
  appBarTheme: const AppBarTheme(
    backgroundColor: FalletterColor.whiteBg,
    foregroundColor: FalletterColor.black,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: FalletterColor.whiteBg,
    selectedItemColor: const Color(0xFF0CDFE6),
    unselectedItemColor: FalletterColor.gray600,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(color: FalletterColor.black),
    helperMaxLines: null,
    hintStyle: const TextStyle(color: FalletterColor.gray600),
    errorMaxLines: null,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    filled: true,
    fillColor: FalletterColor.middleWhite,
    border: WidgetStateInputBorder.resolveWith(_lightBorder),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: FalletterColor.black),
    bodySmall: TextStyle(color: FalletterColor.black),
    labelLarge: TextStyle(color: FalletterColor.black),
    displayLarge: TextStyle(color: FalletterColor.black),
    displayMedium: TextStyle(color: FalletterColor.black),
    displaySmall: TextStyle(color: FalletterColor.black),
    headlineMedium: TextStyle(color: FalletterColor.black),
    headlineSmall: TextStyle(color: FalletterColor.black),
    titleLarge: TextStyle(color: FalletterColor.black),
    titleMedium: TextStyle(color: FalletterColor.black),
    titleSmall: TextStyle(color: FalletterColor.black),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: FalletterColor.black,
    selectionColor: FalletterColor.gray300,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  scaffoldBackgroundColor: FalletterColor.black,
  primaryColor: const Color(0xFF0CDFE6),
  canvasColor: FalletterColor.middleBlack,
  cardColor: FalletterColor.middleBlack,
  appBarTheme: const AppBarTheme(
    backgroundColor: FalletterColor.black,
    foregroundColor: FalletterColor.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: FalletterColor.white),
    bodySmall: TextStyle(color: FalletterColor.white),
    labelLarge: TextStyle(color: FalletterColor.white),
    displayLarge: TextStyle(color: FalletterColor.white),
    displayMedium: TextStyle(color: FalletterColor.white),
    displaySmall: TextStyle(color: FalletterColor.white),
    headlineMedium: TextStyle(color: FalletterColor.white),
    headlineSmall: TextStyle(color: FalletterColor.white),
    titleLarge: TextStyle(color: FalletterColor.white),
    titleMedium: TextStyle(color: FalletterColor.white),
    titleSmall: TextStyle(color: FalletterColor.white),
  ),
);