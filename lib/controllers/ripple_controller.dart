import 'package:flutter/material.dart';

class RippleController with ChangeNotifier {
  RippleController({
    required int circles,
    this.curve = Curves.easeInOut,
    this.repeatDuration = const Duration(seconds: 5),
  })  : _circles = circles,
        _progress = List<double>.filled(circles, 0.0);

  final Curve curve;
  final Duration repeatDuration;
  final List<double> _progress;
  List<double> get progress => List.unmodifiable(_progress);

  final int _circles;
  int get circles => _circles;

  double _totalTime = 0.0;

  bool update(double deltaTime) {
    _totalTime += deltaTime;

    double normalizedTime = (_totalTime % 1.0);

    for (var i = 0; i < _circles; i++) {
      double delay = i * (1.0 / _circles);

      double individualProgress = (normalizedTime - delay) % 1.0;
      if (individualProgress < 0) individualProgress += 1.0;

      _progress[i] = curve.transform(individualProgress);
    }

    notifyListeners();
    return true;
  }
}
