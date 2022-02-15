import 'package:flutter/material.dart' hide FormField;
import 'package:flutter/services.dart';
import 'package:vienna_editor/models/form_field.dart';

class StringFormField extends CustomFormField<String> {
  StringFormField({
    required this.name,
    this.displayName,
    this.hintText,
    this.inputFormatters,
    String? initialValue,
  })  : initialValue = initialValue ?? "",
        _value = initialValue ?? "";

  @override
  final String name;
  @override
  final String? displayName;

  String _value;
  final String initialValue;

  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  String? get value => _value;

  @override
  Widget get widget => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: hintText),
            inputFormatters: inputFormatters,
            initialValue: initialValue,
            onChanged: (val) {
              _value = val;
              notifyListeners();
            },
          ),
        ],
      );
}
