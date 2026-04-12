import 'package:flutter/material.dart';

class PointerPaint extends CustomPainter {
  final Color? color;
  final Gradient? gradient;

  PointerPaint({this.color, this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.style = PaintingStyle.fill;

    final path = Path();
      path.moveTo(size.width / 2, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
      path.close();

    if (gradient != null) {
      paint.shader = gradient!.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );
    } else {
      paint.color = color ?? Colors.grey;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PointerPaint oldDelegate) => false;
}