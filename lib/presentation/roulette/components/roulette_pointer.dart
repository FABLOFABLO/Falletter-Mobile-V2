import 'package:falletter_mobile_v2/core/constants/color.dart';
import 'package:flutter/material.dart';

class PointerPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = FalletterColor.gray200;
    paint.style = PaintingStyle.fill;

    final path = Path();
      path.moveTo(size.width / 2, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
      path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PointerPaint oldDelegate) => false;
}