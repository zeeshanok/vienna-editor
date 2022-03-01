import 'package:flutter/material.dart';

class CanvasSidebar extends StatelessWidget {
  final double width;

  const CanvasSidebar({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Text(
          "Tools",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
