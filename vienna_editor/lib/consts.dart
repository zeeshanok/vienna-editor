import 'dart:io';

import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF1D1D1D);
const secondaryBackgroundColor = Color(0xFF303030);
const defaultEnabledBorderColor = Color(0xFF7D7D7D);
final globalNavigatorKey = GlobalKey<NavigatorState>();

final buttonStyle = ButtonStyle(
  splashFactory: NoSplash.splashFactory,
  elevation: MaterialStateProperty.all(0),
  shadowColor: MaterialStateProperty.all(Colors.transparent),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  overlayColor: MaterialStateProperty.all(const Color(0x8A555555)),
);

final defaultTheme = ThemeData(
  fontFamily: 'Helvetica Neue',
  colorScheme: const ColorScheme.dark(
    primary: Colors.green,
    background: backgroundColor,
    brightness: Brightness.dark,
  ),
  backgroundColor: backgroundColor,
  scaffoldBackgroundColor: backgroundColor,
  textButtonTheme: TextButtonThemeData(style: buttonStyle),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: buttonStyle.copyWith(
    overlayColor:
        MaterialStateProperty.all(const Color.fromARGB(33, 255, 255, 255)),
    padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
  )),
  outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
  buttonTheme: const ButtonThemeData(splashColor: Colors.transparent),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: defaultEnabledBorderColor, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.green, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    isDense: true,
  ),
);

bool isDesktop() => Platform.isWindows || Platform.isMacOS || Platform.isLinux;

Route pageRoute(Widget exitPage, Widget enterPage) =>
    DefaultPageRoute(exitPage: exitPage, enterPage: enterPage);

// PageRouteBuilder(
//   opaque: false,
//   transitionDuration: const Duration(milliseconds: 200),
//   reverseTransitionDuration: const Duration(milliseconds: 100),
//   pageBuilder: (context, animation, secondaryAnimation) => builder(context),
//   transitionsBuilder: (context, animation, secondaryAnimation, child) =>
//       ScaleTransition(
//     scale: CurvedAnimation(
//             curve: Curves.easeInOutCubic, parent: secondaryAnimation)
//         .drive(Tween(begin: 1.15, end: 1)),
//     child: child,
//   ),
// );

class DefaultPageRoute extends PageRouteBuilder {
  final Widget exitPage, enterPage;
  DefaultPageRoute({required this.exitPage, required this.enterPage})
      : super(
          opaque: false,
          transitionDuration: const Duration(milliseconds: 450),
          reverseTransitionDuration: const Duration(milliseconds: 120),
          pageBuilder: (context, _, __) => enterPage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final anim = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubicEmphasized,
              reverseCurve: Curves.easeOutExpo,
            );
            // if (!animation.isCompleted)
            //   SlideTransition(
            //     position: CurvedAnimation(
            //       curve: Curves.easeInOutCubicEmphasized,
            //       reverseCurve: Curves.easeInOutCubicEmphasized.flipped,
            //       parent: animation,
            //     ).drive(Tween(
            //         begin: const Offset(0, 0), end: const Offset(-1, 0))),
            //     child: exitPage,
            //   ),

            // position: CurvedAnimation(
            //   curve: Curves.easeInOutCubicEmphasized,
            //   reverseCurve: Curves.easeInOutCubicEmphasized.flipped,
            //   parent: animation,
            // ).drive(Tween(
            //     begin: const Offset(1, 0), end: const Offset(0, 0))),
            return FadeTransition(
              opacity: anim,
              child: ScaleTransition(
                scale: anim.drive(Tween(begin: 1.15, end: 1)),
                child: child,
              ),
            );
          },
        );
}

bool inRange(num x, num l, num h) => l <= x && x <= h;
