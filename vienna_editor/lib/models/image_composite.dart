import 'dart:ui';

import 'package:vienna_editor/models/canvas_config.dart';
import 'package:vienna_editor/models/canvas_renderable/filled_rect.dart';
import 'package:vienna_editor/models/canvas_renderable/image.dart';
import 'package:vienna_editor/models/canvas_renderable/renderable.dart';

class ImageComposite {
  final List<CanvasRenderable> layers;
  final Size size;
  final Set<int> selectedLayerIndices;

  ImageComposite({required this.layers, required this.size})
      : selectedLayerIndices = {};

  factory ImageComposite.fromCanvasConfig(CanvasConfig config) =>
      ImageComposite(
        layers: [
          CanvasFilledRect(
            position: Offset.zero,
            fillColor: config.backgroundColor,
            size: config.size,
          ),
          const Canvasimage(position: Offset(10, 10))
        ],
        size: config.size,
      );

  void selectLayer(int index) => selectedLayerIndices.add(index);
  void deselectLayer(int index) => selectedLayerIndices.remove(index);
  void toggleSelectLayer(int index) {
    if (!selectedLayerIndices.remove(index)) {
      selectedLayerIndices.add(index);
    }
  }

  bool isSelected(int index) => selectedLayerIndices.contains(index);
}
