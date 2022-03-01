import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vienna_editor/consts.dart';

class ColorPickerSVGradient extends StatelessWidget {
  const ColorPickerSVGradient({
    required this.color,
    required this.onChanged,
    this.size = const Size(double.infinity, 100),
    Key? key,
  }) : super(key: key);

  final HSVColor color;
  final Size size;
  final ValueChanged<HSVColor> onChanged;

  void _handleChanged(double dx, double dy, double maxWidth) =>
      onChanged(HSVColor.fromAHSV(
        color.alpha,
        color.hue,
        (dx / maxWidth).clamp(0, 1),
        (1 - (dy / size.height)).clamp(0, 1),
      ));

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            CustomPaint(
              size: size,
              painter: ColorPickerSVGradientPainter(color),
            ),
            GestureDetector(
              onPanUpdate: (details) => _handleChanged(details.localPosition.dx,
                  details.localPosition.dy, constraints.maxWidth),
              onPanDown: (details) => _handleChanged(details.localPosition.dx,
                  details.localPosition.dy, constraints.maxWidth),
              child: CustomPaint(
                painter: SVThumbPainter(color),
                size: size,
              ),
            ),
          ],
        ),
      ),
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

    canvas.clipRRect(RRect.fromRectAndRadius(rect, const Radius.circular(3)));
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

class SVThumbPainter extends CustomPainter {
  final HSVColor color;

  SVThumbPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final x = color.saturation * size.width;
    final y = (1 - color.value) * size.height;
    final o = Offset(x, y);
    const r = 8.0;

    canvas.drawCircle(o, r, Paint()..color = Colors.white);
    canvas.drawCircle(o, r - 2, Paint()..color = color.toColor());
  }

  @override
  bool shouldRepaint(covariant SVThumbPainter oldDelegate) =>
      oldDelegate.color != color;
}

class ColorPickerHSlider extends StatelessWidget {
  const ColorPickerHSlider({
    required this.hue,
    this.height = 8,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final double hue;
  final double height;
  final ValueChanged<double> onChanged;

  void _handleUpdate(double dx, double width) =>
      onChanged((dx / width * 360).clamp(0, 360));

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            CustomPaint(
              size: Size(double.infinity, height),
              painter: ColorPickerHSliderPainter(),
            ),
            GestureDetector(
              onPanUpdate: (details) =>
                  _handleUpdate(details.localPosition.dx, constraints.maxWidth),
              onPanDown: (details) =>
                  _handleUpdate(details.localPosition.dx, constraints.maxWidth),
              child: CustomPaint(
                size: Size(double.infinity, height),
                painter: ColorPickerHSliderThumbPainter(hue, Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPickerHSliderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final rect = Rect.fromLTWH(0, 0, size.width, h);
    final shader = LinearGradient(
            colors: List.generate(
                360, (i) => HSVColor.fromAHSV(1, i.toDouble(), 1, 1).toColor()))
        .createShader(rect);
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = shader;

    canvas.clipRRect(RRect.fromRectAndRadius(rect, const Radius.circular(3)));
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant ColorPickerHSliderPainter oldDelegate) => false;
}

class ColorPickerHSliderThumbPainter extends CustomPainter {
  final double hue;
  final Color thumbColor;

  ColorPickerHSliderThumbPainter(this.hue, this.thumbColor);

  @override
  void paint(Canvas canvas, Size size) {
    final pos = hue / 360 * size.width;
    final c = Offset(pos, size.height / 2);
    canvas.drawCircle(
      c,
      8,
      Paint()..color = thumbColor,
    );
    canvas.drawCircle(
      c,
      6,
      Paint()..color = HSVColor.fromAHSV(1, hue, 1, 1).toColor(),
    );
  }

  @override
  bool shouldRepaint(covariant ColorPickerHSliderThumbPainter oldDelegate) =>
      oldDelegate.hue != hue;
}

class ColorEditor extends HookWidget {
  const ColorEditor({
    Key? key,
    required this.color,
    required this.onChanged,
    this.allowOpacity = true,
    this.height = 100,
  }) : super(key: key);

  final HSVColor color;
  final ValueChanged<HSVColor> onChanged;
  final bool allowOpacity;
  final double height;

  String getHex(HSVColor c) =>
      c.toColor().value.toRadixString(16).substring(2).toUpperCase();
  String getHsv(HSVColor c) =>
      "${c.hue.round()}°, ${(c.saturation * 100).round()}%, "
      "${(c.value * 100).round()}%";

  void Function(String) _onColorChange(bool isHsv) => isHsv
      ? (text) {
          final s = text.replaceAll(" ", "");
          final reg = RegExp(r"(\d+)°?,(\d+)%?,(\d+)%?");
          final match = reg.firstMatch(s);
          if (match != null) {
            final h = int.parse(match.group(1)!).toDouble();
            final s = int.parse(match.group(2)!) / 100;
            final v = int.parse(match.group(3)!) / 100;
            if (inRange(h, 0, 360) && inRange(s, 0, 1) && inRange(v, 0, 1)) {
              onChanged(
                HSVColor.fromAHSV(1, h, s, v),
              );
            }
          }
        }
      : (text) {
          final parsed = int.tryParse(text, radix: 16);
          if (parsed != null && text.length == 6) {
            onChanged(HSVColor.fromColor(Color(0xFF000000 | parsed)));
          }
        };

  void saveSelection(TextEditingController controller, Function() f) {
    final s = controller.selection;
    f();
    controller.selection = s;
  }

  @override
  Widget build(BuildContext context) {
    const decor =
        InputDecoration(floatingLabelBehavior: FloatingLabelBehavior.always);
    final hexController = useTextEditingController(text: getHex(color));
    final hsvController = useTextEditingController(text: getHsv(color));
    final hexNode = useFocusNode();
    final hsvNode = useFocusNode();

    useValueChanged<HSVColor, void>(color, (_, __) {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        if (!hexNode.hasFocus) {
          saveSelection(
              hexController, () => hexController.text = getHex(color));
        }
        if (!hsvNode.hasFocus) {
          saveSelection(
              hsvController, () => hsvController.text = getHsv(color));
        }
      });
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SeparatedColumn(
        separatorBuilder: () => const SizedBox(height: 14),
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: color.toColor(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 4,
                child: ColorPickerSVGradient(
                  color: color,
                  onChanged: onChanged,
                  size: Size(double.infinity, height),
                ),
              ),
            ],
          ),
          ColorPickerHSlider(
            hue: color.hue,
            height: 12,
            onChanged: (hue) => onChanged(HSVColor.fromAHSV(
              color.alpha,
              hue,
              color.saturation,
              color.value,
            )),
          ),
          SeparatedRow(
            separatorBuilder: () => const SizedBox(width: 8),
            children: [
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: hexController,
                  focusNode: hexNode,
                  decoration: decor.copyWith(labelText: "HEX", prefixText: "#"),
                  onChanged: _onColorChange(false),
                ),
              ),
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: decor.copyWith(labelText: "HSV"),
                  controller: hsvController,
                  focusNode: hsvNode,
                  onChanged: _onColorChange(true),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
