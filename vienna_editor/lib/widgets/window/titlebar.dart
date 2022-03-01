import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart' as bits;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vienna_editor/blocs/window_state_bloc.dart';
import 'package:vienna_editor/consts.dart';
import 'package:vienna_editor/widgets/window/window_control_buttons.dart';

const _s = TextStyle(
  fontWeight: FontWeight.w300,
  letterSpacing: 0.6,
  overflow: TextOverflow.ellipsis,
);

class TitleBar extends StatelessWidget {
  const TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WindowCubit, WindowState>(
      builder: (context, state) {
        final isRegular = state is RegularWindowState;
        return SizedBox(
          height: 30,
          child: Stack(
            children: [
              bits.MoveWindow(
                  child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: isRegular
                      ? Text(
                          state.title,
                          key: const ValueKey("custom titlebar text"),
                          style: _s,
                        )
                      : const Text(
                          "Vienna",
                          key: ValueKey("titlebar text"),
                          style: _s,
                        ),
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (isRegular) {
                        BlocProvider.of<WindowCubit>(context)
                            .setTo(const NewWindowState());
                        globalNavigatorKey.currentState
                            ?.popUntil((route) => route.isFirst);
                      }
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          isRegular
                              ? Icons.home_outlined
                              : Icons.format_paint_rounded,
                          size: 20,
                          color: Colors.grey,
                        )),
                  ),
                  const WindowControlButtons()
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
