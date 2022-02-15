import 'package:flutter/material.dart';

abstract class CustomFormField<T> extends ChangeNotifier {
  /// A null value indicates that the field was empty
  T? get value;

  String get name;
  String? get displayName;
  Map<String, T?> get valueMap => {name: value};

  Widget get widget;
}
