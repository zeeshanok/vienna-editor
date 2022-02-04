import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vienna_editor/models/window_tab_model.dart';
import 'package:vienna_editor/widgets/window_tab.dart';

const _multiplier = 100;

class TabsList extends HookWidget {
  const TabsList({
    required this.onSelected,
    required this.tabs,
    required this.onClose,
    Key? key,
  }) : super(key: key);

  final List<WindowTabModel> tabs;
  final void Function(int) onClose;
  final void Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            final dy = -event.scrollDelta.dy.sign.toInt();
            if (dy.sign.abs() == 1) {
              controller.animateTo(
                controller.offset + dy * _multiplier,
                duration: const Duration(milliseconds: 20),
                curve: Curves.linear,
              );
            }
          }
        },
        child: Row(children: [
          for (var i = 0; i < tabs.length; i++)
            WindowTab(
                title: tabs[i].name,
                onClose: () => onClose(i),
                onClicked: () => onSelected(i),
                selected: tabs[i].selected)
        ])
        // child: ListView.separated(
        //   controller: controller,
        //   scrollDirection: Axis.horizontal,
        //   itemBuilder: (context, i) => WindowTab(
        //     title: tabs[i],
        //     onClose: () => onClose(i),
        //     selected: i == 10,
        //   ),
        //   separatorBuilder: (context, i) => const VerticalDivider(
        //     endIndent: 8,
        //     indent: 8,
        //     width: 4,
        //   ),
        //   itemCount: tabs.length,
        // ),
        );
  }
}
