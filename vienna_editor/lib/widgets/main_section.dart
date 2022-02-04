import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vienna_editor/blocs/window_tab_bloc.dart';
import 'package:vienna_editor/models/window_tab_model.dart';

class MainSection extends StatelessWidget {
  const MainSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WindowTabCubit, List<WindowTabModel>>(
      builder: (context, state) {
        final sIndex = context.read<WindowTabCubit>().selectedIndex;
        return buildTab(state[sIndex], sIndex);
      },
    );
  }

  Widget buildTab(WindowTabModel tab, int i) {
    if (tab.kind == WindowTabKind.newTab) {
      return buildNewTab(i);
    } else {
      return buildRegularTab(tab);
    }
  }

  Widget buildNewTab(int i) {
    return Center(child: Text("new tab $i"));
  }

  Widget buildRegularTab(WindowTabModel tab) {
    return const Text("tab");
  }
}
