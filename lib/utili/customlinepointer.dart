import 'package:flutter/material.dart';

class Customlinepointer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 4, size.height / 4, size.width / 2, size.height / 2);
    path.quadraticBezierTo(
        3 * size.width / 4, 3 * size.height / 4, size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}