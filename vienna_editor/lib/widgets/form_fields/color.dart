import 'package:flutter/material.dart';
import 'package:vienna_editor/models/form_field.dart';
import 'package:vienna_editor/widgets/color_editor.dart';

class ColorFormField extends CustomFormField<Color> {
  @override
  final String name;
  @override
  final String? displayName;

  ColorFormField({
    required this.name,
    this.displayName,
  });

  HSVColor _color = HSVColor.fromColor(Colors.white);

  @override
  Color get value {
    // debugPrint(_color.toString());
    return _color.toColor();
  }

  @override
  Widget get widget => ColorEditor(
        color: _color,
        onChanged: (color) {
          _color = color;
          notifyListeners();
        },
      );
}
