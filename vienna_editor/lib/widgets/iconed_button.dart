import 'package:flutter/material.dart';

class IconedButton extends StatelessWidget {
  const IconedButton(
    this.icon, {
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 16,
      child: TextButton(
          onPressed: onPressed,
          child: icon,
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              foregroundColor: MaterialStateProperty.all(Colors.grey),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.grey[800];
                }
                return null;
              }))),
    );
  }
}
