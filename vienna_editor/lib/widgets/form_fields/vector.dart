import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vienna_editor/models/form_field.dart';

class VectorFormField extends CustomFormField<List<num?>> {
  @override
  final String name;
  @override
  final String? displayName;

  final List<String> _values;

  final String? hintText;
  final List<VectorFieldInfo> infos;

  VectorFormField(
      {required this.infos,
      required this.name,
      this.displayName,
      this.hintText})
      : _values = List.filled(infos.length, "");

  @override
  List<num?> get value => _values.map((e) => num.tryParse(e)).toList();

  @override
  Widget get widget => SeparatedRow(
        separatorBuilder: () => const SizedBox(width: 6),
        children: [
          for (var i = 0; i < infos.length; i++)
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: hintText,
                  suffixText: infos[i].suffix,
                  labelText: infos[i].placeholder,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"\d"))
                ],
                onChanged: (val) {
                  _values[i] = val;
                  notifyListeners();
                },
              ),
            ),
        ],
      );
}

class VectorFieldInfo {
  final String placeholder, suffix;
  final num? initialValue;

  const VectorFieldInfo(this.placeholder, this.suffix, [this.initialValue]);
}
