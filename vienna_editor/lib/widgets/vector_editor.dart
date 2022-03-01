import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vienna_editor/widgets/form_fields/vector.dart';

class VectorEditor extends StatelessWidget {
  const VectorEditor({
    Key? key,
    required this.infos,
    required this.onChanged,
  }) : super(key: key);

  final List<VectorFieldInfo> infos;
  final void Function(int index, num? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return SeparatedRow(
      separatorBuilder: () => const SizedBox(width: 6),
      children: [
        for (var i = 0; i < infos.length; i++)
          Expanded(
            child: TextFormField(
              initialValue: infos[i].initialValue?.toString(),
              decoration: InputDecoration(
                  suffixText: infos[i].suffix,
                  labelText: infos[i].placeholder,
                  floatingLabelBehavior: FloatingLabelBehavior.never),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"\d"))
              ],
              onChanged: (val) {
                final n = num.tryParse(val);
                onChanged(i, n);
              },
            ),
          ),
      ],
    );
  }
}
