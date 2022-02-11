import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class FormField<T> extends ChangeNotifier {
  /// A null value indicates that the field was empty
  T? get value;

  String get name;
  String? get displayName;
  Map<String, T?> get valueMap => {name: value};

  Widget get widget;
}

class StringFormField extends FormField<String> {
  StringFormField({
    required this.name,
    required this.displayName,
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

// class NumberFormField<T extends num> extends FormField<T> {
//   NumberFormField({required this.name, this.hintText});

//   @override
//   final String name;

//   final String? hintText;

//   @override
//   Widget get widget => ;
// }

class IntFormField<T extends num> extends FormField<num> {
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

class FormFieldBuilder extends StatefulWidget {
  const FormFieldBuilder({
    required this.fields,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final List<FormField> fields;
  final ValueChanged<Map<String, dynamic>> onChanged;

  @override
  _FormFieldBuilderState createState() => _FormFieldBuilderState();
}

class _FormFieldBuilderState extends State<FormFieldBuilder> {
  late final fieldValues = <String, dynamic>{
    for (final field in widget.fields) field.name: field.value
  };

  void Function() _onChanged(FormField field) => () {
        setState(() => fieldValues[field.name] = field.value);
        widget.onChanged(fieldValues);
      };

  @override
  void initState() {
    super.initState();
    for (final field in widget.fields) {
      field.addListener(_onChanged(field));
    }
  }

  @override
  void dispose() {
    for (final field in widget.fields) {
      field.removeListener(_onChanged(field));
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (final field in widget.fields)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: field.displayName == null
              ? field.widget
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(field.displayName!),
                    const SizedBox(height: 4),
                    field.widget,
                  ],
                ),
        ),
    ]);
  }
}
