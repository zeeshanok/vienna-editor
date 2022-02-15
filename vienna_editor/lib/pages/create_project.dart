import 'package:flutter/material.dart' hide FormFieldBuilder;
import 'package:flutter/services.dart';
import 'package:vienna_editor/models/form_field.dart';
import 'package:vienna_editor/widgets/back_button.dart';
import 'package:vienna_editor/widgets/form_fields/color.dart';
import 'package:vienna_editor/widgets/form_fields/creator.dart';
import 'package:vienna_editor/widgets/form_fields/string.dart';
import 'package:vienna_editor/widgets/form_fields/vector.dart';
import 'package:vienna_editor/widgets/responsive_builder.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({Key? key}) : super(key: key);

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ResponsiveBuilder(
        desktopBuilder: (context, child) => Row(
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
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      child!,
                    ],
                  ),
                )))
          ],
        ),
        mobileBuilder: (context, child) => Column(
          children: [
            Row(
              children: [
                const PaddedBackButton(),
                const SizedBox(width: 12),
                Text(
                  "Create a blank project.",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child!,
          ],
        ),
        child: const CreateProjectForm(),
      ),
    );
  }
}

class CreateProjectForm extends StatelessWidget {
  const CreateProjectForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormFieldCreator(
      fields: [
        StringFormField(name: "name", displayName: "Name"),
        VectorFormField(
          infos: [VectorFieldInfo("X", "px"), VectorFieldInfo("Y", "px")],
          name: "canvas_size",
          displayName: "Canvas size",
        ),
        ColorFormField(
          name: "bg_color",
          displayName: "Canvas background color",
        )
      ],
      // onChanged: (map) => debugPrint(map.toString()),
      onChanged: (map) {},
      verticalGap: 16.0,
    );
  }
}
