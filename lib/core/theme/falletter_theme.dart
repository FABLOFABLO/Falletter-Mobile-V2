import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:flutter/material.dart';

InputBorder _border(Set<WidgetState> states) {
  Color? color = FalletterColor.middleBlack;

  if (states.contains(WidgetState.focused)) {
    color = FalletterColor.white;
  }

  if (states.contains(WidgetState.error)) {
    color = FalletterColor.error;
  }

  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(width: 1, color: color),
  );
}

InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
  labelStyle: TextStyle(color: FalletterColor.white),
  helperMaxLines: null,
  hintStyle: TextStyle(color: FalletterColor.gray700),
  errorMaxLines: null,
  isDense: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  filled: true,
  fillColor: FalletterColor.middleBlack,
  border: WidgetStateInputBorder.resolveWith(_border),
);

TextSelectionThemeData textSelectionTheme = const TextSelectionThemeData(
  cursorColor: FalletterColor.gray100,
  selectionColor: FalletterColor.gray500,
);
