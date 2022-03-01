import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vienna_editor/blocs/canvas_state_bloc.dart';
import 'package:vienna_editor/widgets/image_composite_widget.dart';

class CanvasWidget extends StatefulWidget {
  const CanvasWidget({Key? key}) : super(key: key);

  @override
  State<CanvasWidget> createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends State<CanvasWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CanvasCubit, CanvasState>(
      builder: (context, state) {
        if (state is CanvasReady) {
          return InteractiveViewer(
            maxScale: 100,
            minScale: 0.1,
            boundaryMargin:
                EdgeInsets.all(state.composite.size.shortestSide / 2),
            constrained: false,
            child: ImageCompositeWidget(
              composite: state.composite,
            ),
          );
        } else {
          return const Text("bruh");
        }
      },
    );
  }
}
