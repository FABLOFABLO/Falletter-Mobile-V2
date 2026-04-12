import 'dart:math';
import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:falletter_mobile_v2/core/constants/color_extension.dart';
import 'package:falletter_mobile_v2/core/constants/text_style.dart';
import 'package:falletter_mobile_v2/core/providers/brick_count_provider.dart';
import 'package:falletter_mobile_v2/core/providers/roulette_provider.dart';
import 'package:falletter_mobile_v2/core/providers/theme/theme_state.dart';
import 'package:falletter_mobile_v2/core/theme/app_theme_color.dart';
import 'package:falletter_mobile_v2/presentation/letter/provider/letter_provider.dart';
import 'package:falletter_mobile_v2/presentation/roulette/components/roulette_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

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
  int selectedIndex = 0;
  double _startAngle = 0.0;
  double _targetAngle = 0.0;

  final rewards = const [
    Reward(RewardType.letter, 1, 18),
    Reward(RewardType.brick, 3, 15),
    Reward(RewardType.letter, 2, 10),
    Reward(RewardType.brick, 5, 5),
    Reward(RewardType.letter, 4, 3),
    Reward(RewardType.miss, 0, 26),
    Reward(RewardType.rewardSet, 2, 2),
    Reward(RewardType.brick, 1, 21),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void spin() {
    final manager = ref.read(rouletteManagerProvider.notifier);
    final currentState = ref.read(rouletteManagerProvider);

    if (currentState.isSpinning) return;

    manager.startSpin();

    final prizeIndex = manager.getRandomIndex();
    final rotationDegrees = manager.calculateRotation(prizeIndex, rewards.length);

    animateRoulette(rotationDegrees, prizeIndex);
  }

  void animateRoulette(double rotationDegrees, int prizeIndex) {
    _startAngle = _targetAngle;
    _targetAngle = _startAngle + (rotationDegrees * pi / 180);

    _controller.reset();
    _controller.forward().then((_) {
      if (!mounted) return;

      final manager = ref.read(rouletteManagerProvider.notifier);

      manager.stopSpin();
      manager.updateFinalAngle(_targetAngle);

      setState(() {
        selectedIndex = prizeIndex;
      });
      applyReward();
    });
  }

  double _getCurrentAngle() {
    final t = Curves.easeOutCubic.transform(_controller.value);
    return _startAngle + (_targetAngle - _startAngle) * t;
  }

  void applyReward() async {
    final reward = rewards[selectedIndex];
    final letterNotifier = ref.read(letterProvider.notifier);
    final brickNotifier = ref.read(brickCountProvider.notifier);

    switch (reward.type) {
      case RewardType.brick:
        await brickNotifier.updateBrickCount(reward.amount);
        break;

      case RewardType.letter:
        await letterNotifier.updateLetterCount(reward.amount);
        break;

      case RewardType.rewardSet:
        await brickNotifier.updateBrickCount(reward.amount);
        await letterNotifier.updateLetterCount(reward.amount);
        break;

      case RewardType.miss:
        break;
    }

    context.push('/reward', extra: reward);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;
    final rouletteState = ref.watch(rouletteManagerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final angle = _getCurrentAngle();
              return Transform.rotate(
                angle: angle,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(300, 300),
                      painter: isDark
                          ? RoulettePaint(count: rewards.length)
                          : RoulettePaint(count: rewards.length,
                        borderGradient: themeColors.progressIndicator,
                      ),
                    ),
                    ..._buildRewardWidgets(angle),
                  ],
                ),
              );
            },
          ),
        ),

        Positioned(
          top: 0,
          child: CustomPaint(
            size: const Size(30, 40),
            painter: isDark
                ? PointerPaint(color: FalletterColor.gray200)
                : PointerPaint(gradient: themeColors.primaryGradient),
          ),
        ),

        GestureDetector(
          onTap: rouletteState.isSpinning ? null : spin,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: themeColors.button,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'GO',
                style: FalletterTextStyle.title1.copyWith(
                  color: context.bgColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildRewardWidgets(double currentAngle) {
    final count = rewards.length;
    final sweep = 2 * pi / count;
    const radius = 100;

    return List.generate(count, (i) {
      final reward = rewards[i];

      final itemAngle = (i * sweep) - (pi / 2);

      final dx = radius * cos(itemAngle);
      final dy = radius * sin(itemAngle);

      return Transform.translate(
        offset: Offset(dx, dy),
        child: Transform.rotate(
          angle: -currentAngle,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (reward.type == RewardType.miss)
                _buildIcon(reward)
              else Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: _buildIcon(reward),
              ),
              if (reward.type != RewardType.miss && reward.type != RewardType.rewardSet)
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Text(
                      'X${reward.amount}',
                      style: FalletterTextStyle.subTitle2.copyWith(color: FalletterColor.white)
                  ),
                ),
              if (reward.type == RewardType.rewardSet)
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20),
                  child: Text(
                      '선물세트',
                      style: FalletterTextStyle.body2.copyWith(
                          fontWeight: FontWeight.bold,
                        color: FalletterColor.white
                      )
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildIcon(Reward reward) {
    final selectedTheme = ref.watch(themeProvider);
    final themeColors = appThemeColors[selectedTheme]!;

    switch (reward.type) {
      case RewardType.brick:
        return SvgPicture.asset(
          themeColors.brickSvg,
          width: 42,
          height: 42,
        );
      case RewardType.letter:
        return SvgPicture.asset(
          themeColors.letterSvg,
          width: 32,
          height: 32,
        );
      case RewardType.miss:
        return SvgPicture.asset(
          themeColors.missSvg,
          width: 46,
          height: 46,
        );
      case RewardType.rewardSet:
        return Padding(
          padding: const EdgeInsets.only(top: 20, right: 5),
          child: SvgPicture.asset(
            themeColors.rewardSetSvg,
            width: 100,
            height: 100,
          ),
        );
    }
  }
}

class RoulettePaint extends CustomPainter {
  final int count;
  final Color? borderColor;
  final Gradient? borderGradient;

  RoulettePaint({
    required this.count,
    this.borderColor,
    this.borderGradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sweep = 2 * pi / count;

    for (int i = 0; i < count; i++) {
      final paint = Paint()
        ..color = i.isEven ? FalletterColor.gray800 : FalletterColor.gray900
        ..style = PaintingStyle.fill;

      final startAngle = (i * sweep) - (pi / 2) - (sweep / 2);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweep,
        true,
        paint,
      );
    }

    final border = Paint()
      ..color = FalletterColor.gray200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    if (borderGradient != null) {
      border.shader = borderGradient!.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );
    } else {
      border.color = borderColor ?? FalletterColor.gray200;
    }

    canvas.drawCircle(center, radius, border);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}