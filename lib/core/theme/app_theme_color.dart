import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:flutter/material.dart';

enum AppTheme { blue, pink, purple }

class ThemeColors {
  final Color primaryColor;
  final Gradient primaryGradient;
  final Gradient text;
  final Gradient button;
  final Gradient floatingButton;
  final Gradient letterModalBorder;
  final Gradient bottomNavIcon;
  final Gradient profile;
  final Gradient progressIndicator;
  final Gradient answerButton;
  final Gradient timer;
  final Gradient hintInitial;
  final Gradient rewardText;
  final Gradient toggleCircleColor;

  final String onBoardingSvg;
  final String letterSvg;
  final String brickSvg;
  final String receivedLetterSvg;
  final String signupLottie;
  final String sendLetterLottie;
  final String noticeSvg;
  final String rouletteCheckSvg;

  ThemeColors({
    required this.primaryColor,
    required this.primaryGradient,
    required this.text,
    required this.button,
    required this.floatingButton,
    required this.letterModalBorder,
    required this.bottomNavIcon,
    required this.profile,
    required this.progressIndicator,
    required this.answerButton,
    required this.timer,
    required this.hintInitial,
    required this.rewardText,
    required this.onBoardingSvg,
    required this.letterSvg,
    required this.brickSvg,
    required this.receivedLetterSvg,
    required this.signupLottie,
    required this.sendLetterLottie,
    required this.noticeSvg,
    required this.rouletteCheckSvg,
    required this.toggleCircleColor,
  });
}

Map<AppTheme, ThemeColors> appThemeColors = {
  AppTheme.blue: ThemeColors(
    primaryColor: FalletterColor.blue,
    primaryGradient: FalletterGradient.horizontal(FalletterColor.blueGradient),
    text: FalletterGradient.vertical(FalletterColor.blueGradient),
    button: FalletterGradient.horizontal(FalletterColor.blueGradient),
    floatingButton: FalletterGradient.vertical(FalletterColor.blueGradient),
    letterModalBorder: FalletterGradient.horizontal(FalletterColor.blueGradient),
    bottomNavIcon: FalletterGradient.horizontal(FalletterColor.blueGradient),
    profile: FalletterGradient.vertical(FalletterColor.blueGradient),
    progressIndicator: FalletterGradient.horizontal(FalletterColor.blueGradient),
    answerButton: FalletterGradient.vertical(FalletterColor.blueGradient),
    timer: FalletterGradient.vertical(FalletterColor.blueGradient),
    hintInitial: FalletterGradient.vertical(FalletterColor.blueGradient),
    rewardText: FalletterGradient.vertical(FalletterColor.blueGradient),
    toggleCircleColor: FalletterGradient.vertical(FalletterColor.blueGradient),
    onBoardingSvg: 'assets/svg/on_boarding/on_boarding_blue.svg',
    letterSvg: 'assets/svg/letter/letter_blue.svg',
    brickSvg: 'assets/svg/brick/brick_blue.svg',
    receivedLetterSvg: 'assets/svg/received_letter/received_letter_blue.svg',
    noticeSvg: 'assets/svg/notice/notice_blue.svg',
    rouletteCheckSvg: 'assets/svg/roulette_check/roulette_blue.svg',
    signupLottie: 'assets/lottie/congratulation.json',
    sendLetterLottie: 'assets/lottie/paperPlane.json',
  ),

  AppTheme.pink: ThemeColors(
    primaryColor: FalletterColor.pink,
    primaryGradient: FalletterGradient.horizontal(FalletterColor.pinkGradient),
    text: FalletterGradient.vertical(FalletterColor.pinkGradient),
    button: FalletterGradient.horizontal(FalletterColor.pinkGradient),
    floatingButton: FalletterGradient.vertical(FalletterColor.pinkGradient),
    letterModalBorder: FalletterGradient.horizontal(FalletterColor.pinkGradient),
    bottomNavIcon: FalletterGradient.horizontal(FalletterColor.pinkGradient),
    profile: FalletterGradient.vertical(FalletterColor.pinkGradient),
    progressIndicator: FalletterGradient.horizontal(FalletterColor.pinkGradient),
    answerButton: FalletterGradient.vertical(FalletterColor.pinkGradient),
    timer: FalletterGradient.vertical(FalletterColor.pinkGradient),
    hintInitial: FalletterGradient.vertical(FalletterColor.pinkGradient),
    rewardText: FalletterGradient.vertical(FalletterColor.pinkGradient),
    toggleCircleColor: FalletterGradient.vertical(FalletterColor.pinkGradient),
    onBoardingSvg: 'assets/svg/on_boarding/on_boarding_pink.svg',
    letterSvg: 'assets/svg/letter/letter_pink.svg',
    brickSvg: 'assets/svg/brick/brick_pink.svg',
    receivedLetterSvg: 'assets/svg/received_letter/received_letter_pink.svg',
    noticeSvg: 'assets/svg/notice/notice_pink.svg',
    rouletteCheckSvg: 'assets/svg/roulette_check/roulette_pink.svg',
    signupLottie: 'assets/lottie/congratulation_pink.json',
    sendLetterLottie: 'assets/lottie/paperPlane_pink.json',
  ),

  AppTheme.purple: ThemeColors(
    primaryColor: FalletterColor.purple,
    primaryGradient: FalletterGradient.horizontal(FalletterColor.purpleGradient),
    text: FalletterGradient.vertical(FalletterColor.purpleGradient),
    button: FalletterGradient.horizontal(FalletterColor.purpleGradient),
    floatingButton: FalletterGradient.vertical(FalletterColor.purpleGradient),
    letterModalBorder: FalletterGradient.horizontal(FalletterColor.purpleGradient),
    bottomNavIcon: FalletterGradient.horizontal(FalletterColor.purpleGradient),
    profile: FalletterGradient.vertical(FalletterColor.purpleGradient),
    progressIndicator: FalletterGradient.horizontal(FalletterColor.purpleGradient),
    answerButton: FalletterGradient.vertical(FalletterColor.purpleGradient),
    timer: FalletterGradient.vertical(FalletterColor.purpleGradient),
    hintInitial: FalletterGradient.vertical(FalletterColor.purpleGradient),
    rewardText: FalletterGradient.vertical(FalletterColor.purpleGradient),
    toggleCircleColor: FalletterGradient.vertical(FalletterColor.purpleGradient),
    onBoardingSvg: 'assets/svg/on_boarding/on_boarding_purple.svg',
    letterSvg: 'assets/svg/letter/letter_purple.svg',
    brickSvg: 'assets/svg/brick/brick_purple.svg',
    receivedLetterSvg: 'assets/svg/received_letter/received_letter_purple.svg',
    noticeSvg: 'assets/svg/notice/notice_purple.svg',
    rouletteCheckSvg: 'assets/svg/roulette_check/roulette_purple.svg',
    signupLottie: 'assets/lottie/congratulation_purple.json',
    sendLetterLottie: 'assets/lottie/paperPlane_purple.json',
  )

};