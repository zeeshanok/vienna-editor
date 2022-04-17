import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Collapsible extends HookWidget {
  final Widget child;
  final bool isCollapsed;
  final double axisAlignment;

  const Collapsible({
    this.axisAlignment = 0,
    required this.isCollapsed,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final anim = useAnimationController(
      duration: const Duration(milliseconds: 200),
      initialValue: isCollapsed ? 0 : 1,
    );

    useValueChanged<bool, void>(isCollapsed, (_, __) {
      if (isCollapsed) {
        anim.reverse();
      } else {
        anim.forward();
      }
    });

    return SizeTransition(
      axis: Axis.horizontal,
      axisAlignment: axisAlignment,
      sizeFactor: CurvedAnimation(
        parent: anim,
        curve: Curves.easeInOutCubic,
      ),
      child: child,
    );
  }
}
