import 'package:flutter/material.dart' hide FormField;
import 'package:flutter/services.dart';
import 'package:vienna_editor/models/form_field.dart';

class IntFormField<T extends num> extends CustomFormField<num> {
  IntFormField({
    required this.name,
    this.displayName,
    this.hintText,
    int? initialValue,
  })  : initialValue = initialValue ?? 0,
        _value = (initialValue ?? 0).toString();

  @override
  final String name;
  @override
  final String? displayName;

  String _value;
  final int initialValue;

  final String? hintText;

  @override
  num? get value => num.tryParse(_value);

  @override
  Widget get widget => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: hintText),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"\d"))],
            initialValue: initialValue.toString(),
            onChanged: (val) {
              _value = val;
              notifyListeners();
            },
          ),
        ],
      );
}
