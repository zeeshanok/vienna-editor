import 'package:flutter/material.dart';

class ColorPickerSVGradient extends StatelessWidget {
  ColorPickerSVGradient({
    required Color color,
    Key? key,
  })  : color = HSVColor.fromColor(color),
        super(key: key);

  final HSVColor color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 100),
      painter: ColorPickerSVGradientPainter(color),
    );
  }
}

class ColorPickerSVGradientPainter extends CustomPainter {
  final HSVColor hsvColor;

  ColorPickerSVGradientPainter(this.hsvColor);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
        center: size.center(Offset.zero),
        width: size.width,
        height: size.height);
    final shaderHorizontal = LinearGradient(colors: [
      Colors.white,
      HSVColor.fromAHSV(1, hsvColor.hue, 1, 1).toColor()
    ]).createShader(rect);

    final shaderVertical = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.transparent, Colors.black],
    ).createShader(rect);

    canvas.drawRect(
        rect,
        Paint()
          ..shader = shaderHorizontal
          ..style = PaintingStyle.fill);
    canvas.drawRect(
        rect,
        Paint()
          ..shader = shaderVertical
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant ColorPickerSVGradientPainter oldDelegate) =>
      oldDelegate.hsvColor != hsvColor;
}

class ColorPickerHSlider extends StatelessWidget {
  const ColorPickerHSlider({Key? key, required this.hue}) : super(key: key);

  final double hue;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 12),
      painter: ColorPickerHSliderPainter(),
    );
  }
}

class ColorPickerHSliderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height / 2;
    final rect = Rect.fromLTWH(0, 0, size.width, h);
    final shader = LinearGradient(
            colors: List.generate(
                360, (i) => HSVColor.fromAHSV(1, i.toDouble(), 1, 1).toColor()))
        .createShader(rect);
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = shader;

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant ColorPickerHSliderPainter oldDelegate) => false;
}
