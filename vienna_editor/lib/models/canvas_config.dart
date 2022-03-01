import 'dart:ui';

class CanvasConfig {
  final String name;
  final Size size;
  final Color backgroundColor;

  CanvasConfig({
    required this.name,
    required this.size,
    required this.backgroundColor,
  }) {
    if (name.isEmpty) {
      throw ArgumentError("Name cannot be empty");
    }
    if (!(size.isFinite && size.height > 0 && size.width > 0)) {
      throw ArgumentError("Sizes must be finite positive numbers");
    }
  }

  static CanvasConfig? tryCreate(
      {required String name,
      required Size size,
      required Color backgroundColor}) {
    try {
      return CanvasConfig(
          name: name, size: size, backgroundColor: backgroundColor);
    } on ArgumentError {
      return null;
    }
  }

  factory CanvasConfig.fromMap(Map<String, dynamic> map) {
    final name = map["name"] as String;
    final s = map["canvas_size"] as List<num?>;
    final x = s[0], y = s[1];
    final color = map["bg_color"] as Color;
    if (name.isEmpty) {
      throw ArgumentError("Name cannot be empty");
    }
    if (x != null && y != null) {
      final size = Size(x.toDouble(), y.toDouble());
      return CanvasConfig(name: name, size: size, backgroundColor: color);
    }
    throw ArgumentError("Size cannot be null");
  }

  static CanvasConfig? tryFromMap(Map<String, dynamic> map) {
    try {
      return CanvasConfig.fromMap(map);
    } catch (_) {
      return null;
    }
  }
}
