import 'dart:math';
import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {
  final Gradient gradient;
  final double progress;
  final double strokeWidth;

  CircleProgress({
    required this.gradient,
    required this.progress,
    required this.strokeWidth
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    const startAngle = -pi / 2;
    final sweepAngle = -2 * pi * progress;

    final paint = Paint();
    paint.shader = gradient.createShader(rect);
    paint.strokeWidth = strokeWidth;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;
    
    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is CircleProgress && oldDelegate.progress != progress;
}