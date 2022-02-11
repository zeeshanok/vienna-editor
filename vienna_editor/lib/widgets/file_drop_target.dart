import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final _color = Colors.blue.withAlpha(100);

class FileDropTarget extends HookWidget {
  const FileDropTarget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hovering = useState(false);

    return Container(
      margin: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: DropTarget(
        onDragEntered: (details) {
          hovering.value = true;
        },
        onDragExited: (details) => hovering.value = false,
        child: DottedBorder(
          color: hovering.value ? _color : Colors.transparent,
          strokeWidth: 1,
          radius: const Radius.circular(5),
          dashPattern: const [8, 7],
          borderType: BorderType.RRect,
          child: Center(
              child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: hovering.value ? null : _color,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: _color, width: 2)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.add,
                  size: 35,
                ),
                Text("Drag your files here"),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
