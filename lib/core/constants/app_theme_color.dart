import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:flutter/material.dart';

enum AppTheme { blue, pink, purple }

class ThemeColors {
  final Gradient primaryGradient;
  final Gradient text;
  final Gradient button;
  final Gradient letterModalBorder;
  final Gradient bottomNavIcon;
  final Gradient profile;
  final Gradient progressIndicator;
  final Gradient answerButton;
  final Gradient timer;
  final Gradient hintInitial;
  final Gradient rewardText;

  final String logoSvg;
  final String letterSvg;
  final String brickSvg;
  final String checkLetterSvg;
  final String signupLottie;
  final String sendLetterLottie;

  ThemeColors({
    required this.primaryGradient,
    required this.text,
    required this.button,
    required this.letterModalBorder,
    required this.bottomNavIcon,
    required this.profile,
    required this.progressIndicator,
    required this.answerButton,
    required this.timer,
    required this.hintInitial,
    required this.rewardText,
    required this.logoSvg,
    required this.letterSvg,
    required this.brickSvg,
    required this.checkLetterSvg,
    required this.signupLottie,
    required this.sendLetterLottie,
  });
}

Map<AppTheme, ThemeColors> appThemeColors = {
  AppTheme.blue: ThemeColors(
    primaryGradient: FalletterGradient.horizontal(FalletterColor.blueGradient),
    text: FalletterGradient.vertical(FalletterColor.blueGradient),
    button: FalletterGradient.horizontal(FalletterColor.blueGradient),
    letterModalBorder: FalletterGradient.horizontal(FalletterColor.blueGradient),
    bottomNavIcon: FalletterGradient.horizontal(FalletterColor.blueGradient),
    profile: FalletterGradient.vertical(FalletterColor.blueGradient),
    progressIndicator: FalletterGradient.horizontal(FalletterColor.blueGradient),
    answerButton: FalletterGradient.vertical(FalletterColor.blueGradient),
    timer: FalletterGradient.vertical(FalletterColor.blueGradient),
    hintInitial: FalletterGradient.vertical(FalletterColor.blueGradient),
    rewardText: FalletterGradient.vertical(FalletterColor.blueGradient),
    logoSvg: 'assets/icon/onBoarding.svg',
    letterSvg: 'assets/icon/letter.svg',
    brickSvg: 'assets/icon/brick.svg',
    checkLetterSvg: 'assets/icon/check_letter.svg',
    signupLottie: 'assets/lottie/congratulation.json',
    sendLetterLottie: 'assets/lottie/paperPlane.json',
  ),

  AppTheme.pink: ThemeColors(
    primaryGradient: FalletterGradient.horizontal(FalletterColor.pinkGradient),
    text: FalletterGradient.vertical(FalletterColor.pinkGradient),
    button: FalletterGradient.horizontal(FalletterColor.pinkGradient),
    letterModalBorder: FalletterGradient.horizontal(FalletterColor.pinkGradient),
    bottomNavIcon: FalletterGradient.horizontal(FalletterColor.pinkGradient),
    profile: FalletterGradient.vertical(FalletterColor.pinkGradient),
    progressIndicator: FalletterGradient.horizontal(FalletterColor.pinkGradient),
    answerButton: FalletterGradient.vertical(FalletterColor.pinkGradient),
    timer: FalletterGradient.vertical(FalletterColor.pinkGradient),
    hintInitial: FalletterGradient.vertical(FalletterColor.pinkGradient),
    rewardText: FalletterGradient.vertical(FalletterColor.pinkGradient),
    logoSvg: 'assets/icon/onBoarding_pink.svg',
    letterSvg: 'assets/icon/letter_pink.svg',
    brickSvg: 'assets/icon/brick_pink.svg',
    checkLetterSvg: 'assets/icon/check_letter_pink.svg',
    signupLottie: 'assets/lottie/congratulation_pink.json',
    sendLetterLottie: 'assets/lottie/paperPlane_pink.json',
  ),

  AppTheme.purple: ThemeColors(
    primaryGradient: FalletterGradient.horizontal(FalletterColor.purpleGradient),
    text: FalletterGradient.vertical(FalletterColor.purpleGradient),
    button: FalletterGradient.horizontal(FalletterColor.purpleGradient),
    letterModalBorder: FalletterGradient.horizontal(FalletterColor.purpleGradient),
    bottomNavIcon: FalletterGradient.horizontal(FalletterColor.purpleGradient),
    profile: FalletterGradient.vertical(FalletterColor.purpleGradient),
    progressIndicator: FalletterGradient.horizontal(FalletterColor.purpleGradient),
    answerButton: FalletterGradient.vertical(FalletterColor.purpleGradient),
    timer: FalletterGradient.vertical(FalletterColor.purpleGradient),
    hintInitial: FalletterGradient.vertical(FalletterColor.purpleGradient),
    rewardText: FalletterGradient.vertical(FalletterColor.purpleGradient),
    logoSvg: 'assets/icon/onBoarding_silver.svg',
    letterSvg: 'assets/icon/letter_silver.svg',
    brickSvg: 'assets/icon/brick_silver.svg',
    checkLetterSvg: 'assets/icon/check_letter_silver.svg',
    signupLottie: 'assets/lottie/congratulation_purple.json',
    sendLetterLottie: 'assets/lottie/paperPlane_purple.json',
  )

};