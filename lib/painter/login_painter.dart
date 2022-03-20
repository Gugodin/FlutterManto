import 'package:flutter/material.dart';
import 'package:veterinariamanto/assets/Colors/color.dart';

class LoginPainter extends CustomPainter {
  double heiDeterminate = 0;
  double wiDeterminate = 0;

  LoginPainter({required this.heiDeterminate, required this.wiDeterminate});
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement pain>:t
  
    final paint = Paint();

    paint.color = ColorSelect.loginBackGround;

    paint.style = PaintingStyle.fill;

    paint.strokeWidth = 5;

    final path = Path();

    path.lineTo(0, heiDeterminate);
    path.quadraticBezierTo(
        wiDeterminate / 10, heiDeterminate * 0.65, wiDeterminate * 0.5, heiDeterminate / 2);

    path.quadraticBezierTo(
        9 * (wiDeterminate / 10), heiDeterminate * 0.35, wiDeterminate, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
