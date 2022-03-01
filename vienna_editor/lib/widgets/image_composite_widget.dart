import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vienna_editor/blocs/canvas_state_bloc.dart';
import 'package:vienna_editor/models/image_composite.dart';

class ImageCompositeWidget extends StatelessWidget {
  final ImageComposite composite;

  const ImageCompositeWidget({Key? key, required this.composite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: composite.size.width,
      height: composite.size.height,
      child: Stack(
        children: [
          for (var i = 0; i < composite.layers.length; i++)
            Positioned(
              top: composite.layers[i].position.dy,
              left: composite.layers[i].position.dx,
              child: GestureDetector(
                onTap: () =>
                    BlocProvider.of<CanvasCubit>(context).toggleSelectLayer(i),
                child: Container(
                  decoration: BoxDecoration(
                      border: composite.isSelected(i)
                          ? Border.all(color: Colors.blue, width: 4)
                          : null),
                  child: composite.layers[i],
                ),
              ),
            )
        ],
      ),
    );
  }
}
