import 'package:flutter/material.dart';
import '../widgets/ripple_animation.dart';
import '../widgets/color_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _size = 300;
  int _circles = 1;
  Color _color = Colors.red;
  Duration _duration = const Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ripple Animation'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: RippleAnimation(
                size: _size,
                circles: _circles,
                color: _color,
                duration: _duration,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizeSlider(
                  size: _size,
                  onChanged: (value) => setState(() => _size = value),
                ),
                CirclesSlider(
                  circles: _circles,
                  onChanged: (value) => setState(() => _circles = value),
                ),
                DurationSlider(
                  duration: _duration,
                  onChanged: (value) => setState(() => _duration = value),
                ),
                ColorButtonsRow(
                  selectedColor: _color,
                  onColorSelected: (color) => setState(() => _color = color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SizeSlider extends StatelessWidget {
  final double size;
  final ValueChanged<double> onChanged;

  const SizeSlider({
    super.key,
    required this.size,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Size: '),
        Expanded(
          child: Slider(
            value: size,
            min: 100,
            max: 500,
            onChanged: onChanged,
          ),
        ),
        Text('${size.toInt()}'),
      ],
    );
  }
}

class CirclesSlider extends StatelessWidget {
  final int circles;
  final ValueChanged<int> onChanged;

  const CirclesSlider({
    super.key,
    required this.circles,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Circles: '),
        Expanded(
          child: Slider(
            value: circles.toDouble(),
            min: 1,
            max: 10,
            divisions: 9,
            onChanged: (value) => onChanged(value.toInt()),
          ),
        ),
        Text('$circles'),
      ],
    );
  }
}

class DurationSlider extends StatelessWidget {
  final Duration duration;
  final ValueChanged<Duration> onChanged;

  const DurationSlider({
    super.key,
    required this.duration,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Duration: '),
        Expanded(
          child: Slider(
            value: duration.inMilliseconds.toDouble(),
            min: 1000,
            max: 5000,
            divisions: 8,
            onChanged: (value) =>
                onChanged(Duration(milliseconds: value.toInt())),
          ),
        ),
        Text('${(duration.inMilliseconds / 1000).toStringAsFixed(1)}s'),
      ],
    );
  }
}

class ColorButtonsRow extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  const ColorButtonsRow({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ColorButton(
          color: Colors.red,
          isSelected: selectedColor == Colors.red,
          onTap: () => onColorSelected(Colors.red),
        ),
        ColorButton(
          color: Colors.blue,
          isSelected: selectedColor == Colors.blue,
          onTap: () => onColorSelected(Colors.blue),
        ),
        ColorButton(
          color: Colors.green,
          isSelected: selectedColor == Colors.green,
          onTap: () => onColorSelected(Colors.green),
        ),
        ColorButton(
          color: Colors.orange,
          isSelected: selectedColor == Colors.orange,
          onTap: () => onColorSelected(Colors.orange),
        ),
      ],
    );
  }
}
