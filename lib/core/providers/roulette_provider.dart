import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum RewardType { brick, letter, miss, rewardSet }

class RouletteState {
  final double angle;
  final bool isSpinning;

  RouletteState({required this.angle, this.isSpinning = false});

  RouletteState copyWith({double? angle, bool? isSpinning}) {
    return RouletteState(
      angle: angle ?? this.angle,
      isSpinning: isSpinning ?? this.isSpinning,
    );
  }
}

class RouletteManager extends StateNotifier<RouletteState> {
  RouletteManager() : super(RouletteState(angle: 0));

  RouletteState build() => RouletteState(angle: 0);

  int getRandomIndex() {
    final random = Random().nextInt(100);
    if (random < 18) return 0;
    else if (random < 33) return 1;
    else if (random < 43) return 2;
    else if (random < 48) return 3;
    else if (random < 51) return 4;
    else if (random < 77) return 5;
    else if (random < 79) return 6;
    else return 7;
  }

  double calculateRotation(int targetIndex, int length) {
    final random = Random();
    final spins = 5 + random.nextInt(3);
    final sectionAngle = 360.0 / length;

    final targetAbsoluteDegrees = 360.0 - (targetIndex * sectionAngle);
    final currentAbsoluteDegrees = (state.angle * 180 / pi) % 360;
    double rotationNeeded = targetAbsoluteDegrees - currentAbsoluteDegrees;
    if (rotationNeeded < 0) rotationNeeded += 360;

    final randomOffset = (random.nextDouble() * (sectionAngle - 10)) - ((sectionAngle - 10) / 2);

    return (spins * 360) + rotationNeeded + randomOffset;
  }

  void startSpin() => state = state.copyWith(isSpinning: true);
  void stopSpin() => state = state.copyWith(isSpinning: false);
  void updateFinalAngle(double newAngle) => state = state.copyWith(angle: newAngle);
}

final rouletteManagerProvider =
StateNotifierProvider.autoDispose<RouletteManager, RouletteState>(
      (ref) => RouletteManager(),
);