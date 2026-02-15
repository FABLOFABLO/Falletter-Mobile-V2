import 'dart:math';

import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/presentation/roulette/components/roulette_pointer.dart';
import 'package:falletter_mobile_v2/presentation/roulette/roulette_reward_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum RewardType { brick, letter, miss }

class Reward {
  final RewardType type;
  final int amount;
  final int weight;

  const Reward(this.type, this.amount, this.weight);
}

class Roulette extends ConsumerStatefulWidget {
  const Roulette({super.key});

  @override
  ConsumerState<Roulette> createState() => _RouletteState();
}

class _RouletteState extends ConsumerState<Roulette> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isSpinning = false;
  int selectedIndex = 0;
  double _currentRotation = 0.0; // 라디안 단위로 저장

  final rewards = [
    Reward(RewardType.miss, 0, 13),
    Reward(RewardType.miss, 0, 13),
    Reward(RewardType.brick, 1, 21),
    Reward(RewardType.letter, 1, 18),
    Reward(RewardType.brick, 3, 15),
    Reward(RewardType.letter, 2, 10),
    Reward(RewardType.brick, 5, 7),
    Reward(RewardType.letter, 4, 3),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void spinRoulette() {
    if (isSpinning) return;

    setState(() {
      isSpinning = true;
    });

    final prizeIndex = getRandomIndex();
    final targetRotation = calculateRotation(prizeIndex);

    animateRoulette(targetRotation, prizeIndex);
  }

  void animateRoulette(double targetRotationDegrees, int prizeIndex) {
    // 현재 회전 각도 (라디안)에서 시작
    final startRotation = _currentRotation;
    // 목표 회전 각도 (라디안)
    final endRotation = _currentRotation + (targetRotationDegrees * pi / 180);

    _animation = Tween<double>(
      begin: startRotation,
      end: endRotation,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.reset();
    _controller.forward().then((_) {
      setState(() {
        _currentRotation = endRotation;
        isSpinning = false;
        selectedIndex = prizeIndex;
      });
      applyReward();
    });
  }

  void applyReward() {
    final reward = rewards[selectedIndex];
    final type = reward.type;
    final amount = reward.amount;

    if (type == RewardType.brick) {
      // TODO: 상태관리로 브릭 추가
    } else if (type == RewardType.letter) {
      // TODO: 상태관리로 레터 추가
    } else {

    }

    context.push('/reward', extra: reward);
    context.pop();
  }

  double calculateRotation(int targetIndex) {
    final random = Random();
    final spins = 5 + random.nextDouble() * 2;
    final sectionAngle = 360.0 / rewards.length;
    final prizeAngle = targetIndex * sectionAngle;
    return (spins * 360) + (360 - prizeAngle) + (sectionAngle / 2);
  }

  int getRandomIndex() {
    final random = Random().nextInt(100);

    if (random < 26) return 0;
    else if (random < 47) return 1;
    else if (random < 65) return 2;
    else if (random < 80) return 3;
    else if (random < 90) return 4;
    else if (random < 97) return 5;
    else return 6;
  }

  @override
  Widget build(BuildContext context) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animation.value,
                child: child,
              );
            },
            child: CustomPaint(
              size: const Size(300, 300),
              painter: RoulettePaint(count: rewards.length),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: CustomPaint(
            size: Size(30, 40),
            painter: PointerPaint(),
          ),
        ),
        GestureDetector(
          onTap: (isSpinning) ? null : spinRoulette,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: themeColors.button,
              shape: BoxShape.circle
            ),
            child: Center(
              child: Text('GO',
                  style: FalletterTextStyle.title1.copyWith(
                      color: FalletterColor.black)
              ),
            ),
          ),
        )
      ],
    );
  }
}

class RoulettePaint extends CustomPainter {
  final int count;

  RoulettePaint({required this.count});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sweep = 2 * pi / count;

    for (int i = 0; i < count; i++) {
      final paint = Paint();
      paint.color = i % 2 == 0
          ? FalletterColor.gray800
          : FalletterColor.gray900;
      paint.style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * sweep,
        sweep,
        true,
        paint,
      );
    }

    final border = Paint();
    border.color = FalletterColor.gray200;
    border.style = PaintingStyle.stroke;
    border.strokeWidth = 5;
    canvas.drawCircle(center, radius, border);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
