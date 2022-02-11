import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart' as bits;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vienna_editor/blocs/window_state_bloc.dart';
import 'package:vienna_editor/widgets/window/window_control_buttons.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: Stack(children: [
          bits.MoveWindow(
              child: Center(
                  child: BlocBuilder<WindowCubit, WindowState>(
            builder: (context, state) => Text(
              state is RegularWindowState ? state.title : "Vienna",
              style: const TextStyle(
                  fontWeight: FontWeight.w300, letterSpacing: 0.6),
            ),
          ))),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: bits.MoveWindow(child: const FlutterLogo(size: 20)),
            ),
            const WindowControlButtons()
          ]),
        ]));
  }
}
