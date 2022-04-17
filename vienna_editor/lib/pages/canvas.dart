import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vienna_editor/consts.dart';
import 'package:vienna_editor/widgets/canvas_sidebar.dart';
import 'package:vienna_editor/widgets/canvas_widget.dart';
import 'package:vienna_editor/widgets/collapsible.dart';
import 'package:vienna_editor/widgets/simple_button.dart';

class CanvasPage extends HookWidget {
  const CanvasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leftCollapsed = useState(false);
    final rightCollapsed = useState(true);

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Collapsible(
            isCollapsed: leftCollapsed.value,
            axisAlignment: 1,
            child: const SizedBox(
              width: 60,
              child: Icon(Icons.ac_unit),
            ),
          ),
          SimpleButton(
            onPressed: () => leftCollapsed.value = !leftCollapsed.value,
            child: const Icon(
              Icons.chevron_right,
              size: 18,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: secondaryBackgroundColor,
                  child: const Center(child: CanvasWidget()),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 70,
                    child: Container(
                      margin: const EdgeInsets.all(14),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(96, 0, 0, 0),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(1, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: defaultTheme.colorScheme.background,
                      ),
                      child: SeparatedRow(
                        mainAxisSize: MainAxisSize.min,
                        separatorBuilder: () => const SizedBox(width: 16),
                        children: const [
                          Icon(Icons.add, size: 18),
                          Icon(Icons.search, size: 24),
                          Icon(Icons.remove, size: 18),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SimpleButton(
            onPressed: () => rightCollapsed.value = !rightCollapsed.value,
            child: const Icon(
              Icons.chevron_left,
              size: 18,
            ),
          ),
          Collapsible(
            axisAlignment: -1,
            isCollapsed: rightCollapsed.value,
            child: const CanvasSidebar(width: 350),
          )
        ],
      ),
    );
  }
}
