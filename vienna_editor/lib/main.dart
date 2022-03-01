import 'package:bitsdojo_window/bitsdojo_window.dart' as bits;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vienna_editor/blocs/canvas_state_bloc.dart';
import 'package:vienna_editor/blocs/window_state_bloc.dart';
import 'package:vienna_editor/consts.dart';
import 'package:vienna_editor/pages/home.dart';
import 'package:vienna_editor/widgets/main_section.dart';
import 'package:vienna_editor/widgets/responsive_builder.dart';
import 'package:vienna_editor/widgets/window/titlebar.dart';

void main() {
  runApp(const NewApp());
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
          home: SafeArea(
            child: Scaffold(
              body: ResponsiveBuilder(
                desktopBuilder: (context, child) => Column(
                  children: [const TitleBar(), Expanded(child: child!)],
                ),
                mobileBuilder: (context, child) => child!,
                child: MainSection(),
              ),
            ),
          ),
        ));
  }
}

class NewApp extends StatelessWidget {
  const NewApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WindowCubit()),
        BlocProvider(create: (context) => CanvasCubit()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        theme: defaultTheme,
        debugShowCheckedModeBanner: false,
        navigatorKey: globalNavigatorKey,
        builder: (context, child) => ResponsiveBuilder(
          mobileBuilder: (context, child) => child!,
          desktopBuilder: (context, child) => Container(
            color: defaultTheme.colorScheme.background,
            child: Column(
              children: [
                const Material(
                  child: TitleBar(),
                  color: Colors.transparent,
                ),
                Expanded(
                  child: ClipRect(
                    child: child!,
                  ),
                ),
              ],
            ),
          ),
          child: child,
        ),
        home: const HomePage(),
      ),
    );
  }
}

void doAfterLaunchTasks() {
  if (isDesktop()) {
    bits.doWhenWindowReady(() {
      const size = Size(800, 450);
      bits.appWindow.size = bits.appWindow.minSize = size;
      bits.appWindow.alignment = Alignment.center;
      bits.appWindow.title = "Vienna";
      bits.appWindow.show();
    });
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: defaultTheme.colorScheme.background,
      systemNavigationBarColor: defaultTheme.colorScheme.background,
    ));
  }
}
