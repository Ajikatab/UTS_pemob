import 'dart:math' as math;
import 'package:flutter/material.dart';

class CalorieGaugePainter extends CustomPainter {
  final double value;
  final double maxValue;

  CalorieGaugePainter({required this.value, this.maxValue = 3000});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.7); // Letakkan lebih rendah
    final radius = size.width * 0.3; // Perkecil radius

    // Background arc (grey)
    final backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15; // Kurangi lebar stroke

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      backgroundPaint,
    );

    // Calculate color based on value
    Color gaugeColor;
    if (value < maxValue * 0.5) {
      gaugeColor = Colors.yellow;
    } else if (value < maxValue * 0.75) {
      gaugeColor = Colors.green;
    } else {
      gaugeColor = Colors.red;
    }

    // Value arc
    final valuePaint = Paint()
      ..color = gaugeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15 // Kurangi lebar stroke
      ..strokeCap = StrokeCap.round;

    final valueAngle = (value / maxValue) * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      valueAngle,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
