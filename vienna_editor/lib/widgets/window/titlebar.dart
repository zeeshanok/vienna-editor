import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart' as bits;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vienna_editor/blocs/window_tab_bloc.dart';
import 'package:vienna_editor/models/window_tab_model.dart';
import 'package:vienna_editor/widgets/iconed_button.dart';
import 'package:vienna_editor/widgets/window/tabs_list.dart';
import 'package:vienna_editor/widgets/window/window_control_buttons.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: bits.MoveWindow(child: const FlutterLogo(size: 20)),
          ),
          BlocBuilder<WindowTabCubit, List<WindowTabModel>>(
            builder: (context, state) => TabsList(
              tabs: state,
              onClose: (i) => context.read<WindowTabCubit>().closeTab(i),
              onSelected: (i) =>
                  context.read<WindowTabCubit>().makeTabSelected(i),
            ),
          ),
          IconedButton(const Icon(Icons.add, size: 15),
              onPressed: () => context.read<WindowTabCubit>().newTab()),
          Expanded(
              child: Container(
                  constraints: const BoxConstraints(minWidth: 50),
                  child: bits.MoveWindow())),
          const WindowControlButtons()
        ],
      ),
    );
  }
}
