import 'package:flutter/material.dart';
import 'package:vienna_editor/models/canvas_renderable/renderable.dart';

class CanvasFilledRect extends StatelessWidget implements CanvasRenderable {
  @override
  final Offset position;
  @override
  final String name = "Background";
  final Color fillColor;
  final Size size;

  const CanvasFilledRect({
    Key? key,
    required this.position,
    required this.fillColor,
    required this.size,
  }) : super(key: key);

  @override
  void renderOnCanvas(Canvas canvas) {
    canvas.drawColor(fillColor, BlendMode.src);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fillColor,
      height: size.height,
      width: size.width,
    );
  }
}
