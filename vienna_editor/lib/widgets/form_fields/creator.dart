import 'package:flutter/material.dart' hide FormFieldBuilder, FormField;
import 'package:vienna_editor/models/form_field.dart';
import 'package:flextras/flextras.dart';

class FormFieldCreator extends StatefulWidget {
  const FormFieldCreator({
    required this.fields,
    required this.onChanged,
    this.verticalGap = 8,
    Key? key,
  }) : super(key: key);

  final List<CustomFormField> fields;
  final double verticalGap;
  final ValueChanged<Map<String, dynamic>> onChanged;

  @override
  _FormFieldCreatorState createState() => _FormFieldCreatorState();
}

class _FormFieldCreatorState extends State<FormFieldCreator> {
  late final fieldValues = <String, dynamic>{
    for (final field in widget.fields) field.name: field.value
  };

  void Function() _onChanged(CustomFormField field) => () {
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
    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      separatorBuilder: () => SizedBox(height: widget.verticalGap),
      children: [
        for (final field in widget.fields)
          field.displayName == null
              ? field.widget
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(field.displayName!),
                    const SizedBox(height: 4),
                    field.widget,
                  ],
                ),
      ],
    );
  }
}
