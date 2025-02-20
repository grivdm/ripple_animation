import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../controllers/ripple_controller.dart';
import '../painters/ripple_painter.dart';

class RippleAnimation extends StatefulWidget {
  const RippleAnimation({
    super.key,
    this.size = 300.0,
    this.circles = 5,
    this.color = Colors.red,
    this.duration = const Duration(seconds: 3),
    this.repeatDuration = const Duration(seconds: 5),
  });

  final double size;
  final int circles;
  final Color color;
  final Duration duration;
  final Duration repeatDuration;

  @override
  State<RippleAnimation> createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation>
    with SingleTickerProviderStateMixin {
  late final RippleController _controller;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _controller = RippleController(
      circles: widget.circles,
      curve: Curves.easeInOut,
      repeatDuration: widget.repeatDuration,
    );
    _ticker = createTicker(_onTick());
    _ticker.start();
  }

  @override
  void dispose() {
    _controller.dispose();
    _ticker.dispose();
    super.dispose();
  }

  void Function(Duration elapsed) _onTick() {
    var prev = Duration.zero;
    return (elapsed) {
      final delta = (elapsed - prev).inMicroseconds /
          1000000.0 /
          widget.duration.inSeconds;
      _controller.update(delta);
      prev = elapsed;
    };
  }

  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: RepaintBoundary(
            child: CustomPaint(
              painter: RipplePainter(
                controller: _controller,
                color: widget.color,
              ),
            ),
          ),
        ),
      );
}
