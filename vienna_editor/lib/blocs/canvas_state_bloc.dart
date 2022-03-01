import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vienna_editor/models/canvas_config.dart';
import 'package:vienna_editor/models/image_composite.dart';

class CanvasCubit extends Cubit<CanvasState> {
  CanvasCubit() : super(CanvasInitial());

  void createCanvas(CanvasConfig config) => emit(CanvasReady(config));
  void toggleSelectLayer(int index) {
    final s = state;
    if (s is CanvasReady) {
      s.composite.toggleSelectLayer(index);
      emit(s);
    }
  }

  void destroyCanvas() => emit(CanvasInitial());
}

abstract class CanvasState {}

class CanvasInitial extends CanvasState {}

class CanvasReady extends CanvasState {
  final CanvasConfig config;
  final ImageComposite composite;

  CanvasReady(this.config)
      : composite = ImageComposite.fromCanvasConfig(config);
}
