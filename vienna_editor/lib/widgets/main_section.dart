import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vienna_editor/blocs/window_state_bloc.dart';
import 'package:vienna_editor/pages/home.dart';

class MainSection extends StatelessWidget {
  MainSection({Key? key}) : super(key: key);

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await navigatorKey.currentState?.maybePop();
        return false;
      },
      child: Navigator(
        initialRoute: '/',
        key: navigatorKey,
        onGenerateRoute: (settings) {
          final name = settings.name;
          switch (name) {
            case "/":
              return PageRouteBuilder(
                  pageBuilder: (context, _, __) => const HomePage());
          }
        },
      ),
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
