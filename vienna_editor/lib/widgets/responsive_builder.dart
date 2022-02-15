import 'package:flutter/material.dart';
import 'package:vienna_editor/consts.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    Key? key,
    required this.mobileBuilder,
    required this.desktopBuilder,
    this.child,
  }) : super(key: key);

  final Widget Function(BuildContext context, Widget? child) mobileBuilder,
      desktopBuilder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return isDesktop()
        ? desktopBuilder(context, child)
        : mobileBuilder(context, child);
  }
}
