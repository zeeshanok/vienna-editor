import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vienna_editor/consts.dart';
import 'package:vienna_editor/pages/create_project.dart';

final _style = ButtonStyle(
  side: MaterialStateProperty.all(
      const BorderSide(color: Color(0xFF7D7D7D), width: 2)),
  backgroundColor: MaterialStateProperty.all(const Color(0xFF303030)),
  shadowColor: MaterialStateProperty.all(Colors.transparent),
  elevation: MaterialStateProperty.all(0),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
  ),
);

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dragDropping = useState(false);

    return DropTarget(
      onDragEntered: (details) => dragDropping.value = true,
      onDragExited: (details) => dragDropping.value = false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 2, 10, 10),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: dragDropping.value
              ? Theme.of(context).colorScheme.primary.withAlpha(160)
              : Colors.transparent,
          dashPattern: const [12, 16],
          radius: const Radius.circular(2),
          strokeCap: StrokeCap.round,
          strokeWidth: 2,
          child: Center(
            child: SizedBox(
              width: 160,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox.square(
                    dimension: 160,
                    child: OutlinedButton(
                      style: _style,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            size: 60,
                          ),
                          Text(
                            isDesktop()
                                ? "Drag and drop files or click to add files"
                                : "Tap to add files",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(DefaultPageRoute(
                          exitPage: this,
                          enterPage: const CreateProjectPage()));
                    },
                    child: const Text("Create blank project",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    style: _style,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
