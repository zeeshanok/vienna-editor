import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vienna_editor/blocs/canvas_state_bloc.dart';
import 'package:vienna_editor/blocs/window_state_bloc.dart';
import 'package:vienna_editor/consts.dart';
import 'package:vienna_editor/models/canvas_config.dart';
import 'package:vienna_editor/pages/canvas.dart';
import 'package:vienna_editor/widgets/back_button.dart';
import 'package:vienna_editor/widgets/color_editor.dart';
import 'package:vienna_editor/widgets/form_fields/vector.dart';
import 'package:vienna_editor/widgets/label.dart';
import 'package:vienna_editor/widgets/responsive_builder.dart';
import 'package:vienna_editor/widgets/vector_editor.dart';

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
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  final CanvasConfig? config = CanvasConfig(
    name: "Untitled",
    size: const Size(1600, 900),
    backgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ResponsiveBuilder(
            key: const ValueKey("ok"),
            desktopBuilder: (context, child) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const PaddedBackButton(),
                const SizedBox(width: 14),
                Container(
                    padding: const EdgeInsets.all(18),
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: secondaryBackgroundColor,
                    ),
                    child: SingleChildScrollView(
                      child: SeparatedColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        separatorBuilder: () => const SizedBox(height: 16),
                        children: [
                          Text(
                            "Create a blank project.",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: child!,
                          ),
                        ],
                      ),
                    ))
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
                Expanded(child: SingleChildScrollView(child: child!)),
              ],
            ),
            child: CreateProjectForm(config!),
          ),
        ),
      ),
    );
  }
}

class CreateProjectForm extends HookWidget {
  const CreateProjectForm(this.initialConfig, {Key? key}) : super(key: key);

  final CanvasConfig initialConfig;

  @override
  Widget build(BuildContext context) {
    final name = useState(initialConfig.name);
    final sizeX = useState<double?>(initialConfig.size.width);
    final sizeY = useState<double?>(initialConfig.size.height);
    final color = useState(HSVColor.fromColor(initialConfig.backgroundColor));

    final config = CanvasConfig.tryCreate(
      backgroundColor: color.value.toColor(),
      name: name.value,
      size: sizeX.value != null && sizeY.value != null
          ? Size(sizeX.value!.toDouble(), sizeY.value!.toDouble())
          : const Size(0, 0),
    );

    return BlocListener<CanvasCubit, CanvasState>(
      listener: (context, state) {
        if (state is CanvasReady) {
          Navigator.of(context).push(DefaultPageRoute(
            exitPage: Scaffold.of(context).widget,
            enterPage: const CanvasPage(),
          ));
        }
      },
      child: SeparatedColumn(
        separatorBuilder: () => const SizedBox(height: 16),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(
            label: "Name",
            child: TextFormField(
              initialValue: initialConfig.name,
              onChanged: (s) => name.value = s,
            ),
          ),
          Label(
            label: "Canvas size",
            child: VectorEditor(
              infos: const [
                VectorFieldInfo("Width", "px", 1600),
                VectorFieldInfo("Height", "px", 900),
              ],
              onChanged: (i, val) {
                if (i == 0) {
                  sizeX.value = val?.toDouble();
                } else if (i == 1) {
                  sizeY.value = val?.toDouble();
                }
              },
            ),
          ),
          Label(
            label: "Canvas background color",
            child: ColorEditor(
              color: color.value,
              onChanged: (c) {
                color.value = c;
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: config == null
                  ? null
                  : () {
                      BlocProvider.of<WindowCubit>(context)
                          .setTo(RegularWindowState(config.name));
                      BlocProvider.of<CanvasCubit>(context)
                          .createCanvas(config);
                    },
              child: const Text("Create"),
            ),
          )
        ],
      ),
    );
  }
}
