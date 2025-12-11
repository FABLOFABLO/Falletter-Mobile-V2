import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:flutter/material.dart';

abstract final class FalletterTextStyle {
  /// Title
  static TextStyle title1 = defaultTextStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
  );

  static TextStyle title2 = defaultTextStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static TextStyle title3 = defaultTextStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  /// SubTitle
  static TextStyle subTitle1 = defaultTextStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subTitle2 = defaultTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  /// Body
  static TextStyle body1 = defaultTextStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static TextStyle body2 = defaultTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle body3 = defaultTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle body4 = defaultTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  /// Etc
  static TextStyle label = defaultTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle placeholder = defaultTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle button = defaultTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

const TextStyle defaultTextStyle = TextStyle(
  color: FalletterColor.white,
  fontFamily: 'WantedSans',
);
