import 'package:flutter/material.dart';
import 'package:vienna_editor/widgets/iconed_button.dart';

class WindowTab extends StatefulWidget {
  const WindowTab({
    Key? key,
    required this.title,
    required this.onClose,
    required this.selected,
    required this.onClicked,
  }) : super(key: key);
  final String title;
  final VoidCallback onClose;
  final VoidCallback onClicked;
  final bool selected;

  @override
  State<WindowTab> createState() => _WindowTabState();
}

class _WindowTabState extends State<WindowTab>
    with MaterialStateMixin<WindowTab> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => addMaterialState(MaterialState.hovered),
      onExit: (event) => removeMaterialState(MaterialState.hovered),
      child: GestureDetector(
        onTertiaryTapDown: (details) => widget.onClose(),
        onTap: widget.onClicked,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.selected
                    ? Theme.of(context).colorScheme.primary
                    : (isHovered ? Colors.grey : Colors.transparent),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    color: widget.selected || isHovered
                        ? Colors.white
                        : Colors.grey),
              ),
              const SizedBox(width: 10),
              IconedButton(
                Icon(Icons.close,
                    size: 12,
                    color: widget.selected || isHovered
                        ? null
                        : Colors.transparent),
                onPressed: widget.onClose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
