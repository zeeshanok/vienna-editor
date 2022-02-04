import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart' as bits;

class WindowControlButtons extends StatelessWidget {
  const WindowControlButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        MinimizeWinButton(),
        MaximizeWinButton(),
        CloseWinButton(),
      ],
    );
  }
}

final defaultStyle = ButtonStyle(
  splashFactory: NoSplash.splashFactory,
  foregroundColor: MaterialStateProperty.all(Colors.white),
  shadowColor: MaterialStateProperty.all(Colors.transparent),
  overlayColor: MaterialStateProperty.all(Colors.transparent),
  side: MaterialStateProperty.all(BorderSide.none),
  shape: MaterialStateProperty.all(
      const ContinuousRectangleBorder(borderRadius: BorderRadius.zero)),
  minimumSize: MaterialStateProperty.all(const Size(45, 25)),
  padding: MaterialStateProperty.all(EdgeInsets.zero),
  elevation: MaterialStateProperty.all(0),
);

final closeStyle = defaultStyle.copyWith(
  backgroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.red[600];
    }
    if (states.contains(MaterialState.hovered)) {
      return Colors.red;
    }
    return Colors.transparent;
  }),
);

final maximizeStyle = defaultStyle.copyWith(
  backgroundColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.grey[700];
    }
    if (states.contains(MaterialState.hovered)) {
      return Colors.grey[800];
    }
    return Colors.transparent;
  }),
);

class MinimizeWinButton extends StatelessWidget {
  const MinimizeWinButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => bits.appWindow.minimize(),
      child: const Icon(
        Icons.remove,
        size: 16,
      ),
      style: maximizeStyle,
    );
  }
}

class MaximizeWinButton extends StatelessWidget {
  const MaximizeWinButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => bits.appWindow.maximizeOrRestore(),
      child: const Icon(
        Icons.crop_square,
        size: 16,
      ),
      style: maximizeStyle,
    );
  }
}

class CloseWinButton extends StatelessWidget {
  const CloseWinButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => bits.appWindow.close(),
      child: const Icon(
        Icons.close,
        size: 16,
      ),
      style: closeStyle,
    );
  }
}
