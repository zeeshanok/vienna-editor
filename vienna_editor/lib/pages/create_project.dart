import 'package:flutter/material.dart' hide FormFieldBuilder;
import 'package:vienna_editor/models/form_field.dart';
import 'package:vienna_editor/widgets/back_button.dart';

class CreateProjectPage extends StatelessWidget {
  const CreateProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PaddedBackButton(),
          const SizedBox(width: 14),
          Container(
              padding: const EdgeInsets.all(18),
              height: double.infinity,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFF303030),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create a blank project.",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const Text("Canvas size"),
                    const SizedBox(height: 6),
                    const TextField(
                      cursorWidth: 1.5,
                      decoration: InputDecoration(hintText: "Name"),
                    ),
                    const SizedBox(height: 16),
                    const Text("Canvas size"),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Expanded(
                          child: TextField(
                              decoration: InputDecoration(
                                  hintText: "X", suffixText: "px")),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                            child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Y", suffixText: "px")))
                      ],
                    ),
                    const SizedBox(height: 16),
                    FormFieldBuilder(fields: [
                      StringFormField(
                          name: "size",
                          displayName: "Canvas size",
                          initialValue: "bruh"),
                      IntFormField(
                          name: "int", displayName: "hm", initialValue: 23),
                      StringFormField(name: "lol", displayName: "ok")
                    ], onChanged: (map) => debugPrint(map.toString()))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
