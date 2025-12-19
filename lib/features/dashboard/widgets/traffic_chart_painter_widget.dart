import 'dart:math';

import 'package:flutter/material.dart';

class TrafficChartPainterWidget extends CustomPainter {
  TrafficChartPainterWidget({
    required this.color,
    required this.points,
  });

  final Color color;
  final List<double> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) {
      return;
    }

    final paintLine = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final stepX = size.width / max(points.length - 1, 1);
    final minY = points.reduce(min);
    final maxY = points.reduce(max);
    final range = max(maxY - minY, 0.0001);

    double getY(int i) {
      final normalized = (points[i] - minY) / range;
      return size.height - normalized * (size.height * 0.8) - size.height * 0.1;
    }

    path.moveTo(0, getY(0));
    for (int i = 1; i < points.length; i++) {
      final x = stepX * i;
      final y = getY(i);
      path.lineTo(x, y);
    }

    final shadowPaint = Paint()
      ..color = color.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawPath(path, shadowPaint);

    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant TrafficChartPainterWidget oldDelegate) {
    return oldDelegate.color != color || oldDelegate.points != points;
  }
}
