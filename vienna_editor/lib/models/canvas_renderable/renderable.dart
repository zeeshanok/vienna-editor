import 'package:flutter/material.dart';

abstract class CanvasRenderable extends Widget {
  const CanvasRenderable({Key? key}) : super(key: key);

  Offset get position;
  String get name;

  void renderOnCanvas(Canvas canvas);
}
