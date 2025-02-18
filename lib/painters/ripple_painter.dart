import 'package:flutter/material.dart';
import '../controllers/ripple_controller.dart';

class RipplePainter extends CustomPainter {
  const RipplePainter({
    required RippleController controller,
    required this.color,
  })  : _controller = controller,
        super(repaint: controller);

  final RippleController _controller;
  final Color color;

  static const double minOpacity = 0.1;
  static const double maxOpacity = 0.6;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    for (var i = 0; i < _controller.circles; i++) {
      final progress = _controller.progress[i];
      final radius = maxRadius * progress;
      final opacity = (maxOpacity * (1 - progress) + minOpacity)
          .clamp(minOpacity, maxOpacity);

      final paint = Paint()
        ..color = color.withOpacity(opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) =>
      !identical(oldDelegate._controller, _controller) ||
      oldDelegate.color != color;

  @override
  bool shouldRebuildSemantics(covariant RipplePainter oldDelegate) => false;
}
