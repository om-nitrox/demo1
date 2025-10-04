import 'dart:math' as math;
import 'package:flutter/material.dart';

class DonutChart extends StatelessWidget {
  const DonutChart({super.key, required this.values, this.colors});

  final List<double> values; // e.g. [pending, done, scheduled]
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    final List<Color> palette = colors ?? <Color>[
      const Color(0xFFFFA726), // orange
      const Color(0xFF42A5F5), // blue
      const Color(0xFF9575CD), // purple
    ];
    return CustomPaint(
      painter: _DonutPainter(values: values, colors: palette),
      child: const SizedBox(width: 200, height: 200),
    );
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter({required this.values, required this.colors});
  final List<double> values;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final double total = values.fold(0, (double a, double b) => a + b);
    if (total <= 0) return;
    final Rect rect = Offset.zero & size;
    final double stroke = size.width * 0.12;
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    double start = -math.pi / 2;
    for (int i = 0; i < values.length; i++) {
      final double sweep = (values[i] / total) * 2 * math.pi;
      paint.color = colors[i % colors.length];
      canvas.drawArc(rect.deflate(stroke / 2 + 4), start, sweep, false, paint);
      start += sweep;
    }

    // center circle
    final Paint center = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(size.center(Offset.zero), size.width * 0.28, center);
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.colors != colors;
  }
}


