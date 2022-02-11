import 'package:flutter/material.dart';
import 'package:vienna_editor/blocs/window_state_bloc.dart';
import 'package:vienna_editor/pages/home.dart';

class MainSection extends StatelessWidget {
  const MainSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/home',
      onGenerateRoute: (settings) {
        final name = settings.name;
        switch (name) {
          case "/home":
            return PageRouteBuilder(
                pageBuilder: (context, _, __) => const HomePage());

          // case "/createProject":
          //   return pageRoute(this, const CreateProjectPage());
        }
      },
    );
  }

  Widget buildTab(WindowState tab) {
    if (tab is RegularWindowState) {
      return buildRegularTab(tab.title);
    } else {
      return buildNewTab();
    }
  }

  Widget buildNewTab() {
    return const HomePage();
  }

  Widget buildRegularTab(String title) {
    return Text(title);
  }
}
