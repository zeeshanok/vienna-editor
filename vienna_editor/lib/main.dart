import 'package:bitsdojo_window/bitsdojo_window.dart' as bits;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vienna_editor/blocs/window_state_bloc.dart';
import 'package:vienna_editor/blocs/window_tab_bloc.dart';
import 'package:vienna_editor/consts.dart';
import 'package:vienna_editor/widgets/main_section.dart';
import 'package:vienna_editor/widgets/window/titlebar.dart';

void main() {
  runApp(const App());
  doAfterLaunchTasks();
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WindowCubit(),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        theme: defaultTheme,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(
            children: [
              if (isDesktop()) const TitleBar(),
              Expanded(child: MainSection())
            ],
          ),
        ),
      ),
    );
  }
}

void doAfterLaunchTasks() {
  bits.doWhenWindowReady(() {
    const size = Size(800, 450);
    bits.appWindow.size = bits.appWindow.minSize = size;
    bits.appWindow.alignment = Alignment.center;
    bits.appWindow.title = "Vienna";
    bits.appWindow.show();
  });
}
