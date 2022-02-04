import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF1D1D1D);
final buttonStyle = ButtonStyle(
  splashFactory: NoSplash.splashFactory,
  foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
    return null;
  }),
);

final defaultTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: Colors.green,
    background: backgroundColor,
    brightness: Brightness.dark,
  ),
  backgroundColor: backgroundColor,
  scaffoldBackgroundColor: backgroundColor,
  textButtonTheme: TextButtonThemeData(style: buttonStyle),
  elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
  outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
  buttonTheme: const ButtonThemeData(splashColor: Colors.transparent),
);
