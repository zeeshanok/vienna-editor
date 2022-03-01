import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const ContinuousRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide.none,
          ),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
      ),
    );
  }
}
