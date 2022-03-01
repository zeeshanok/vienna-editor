import 'package:flutter/material.dart';
import 'package:vienna_editor/models/canvas_renderable/renderable.dart';

class Canvasimage extends StatelessWidget implements CanvasRenderable {
  @override
  final Offset position;

  @override
  final String name = "Image";

  const Canvasimage({
    required this.position,
    Key? key,
  }) : super(key: key);

  @override
  void renderOnCanvas(Canvas canvas) {}

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://cdn.download.ams.birds.cornell.edu/api/v1/asset/202984001/1200",
      height: 200,
    );
  }
}
