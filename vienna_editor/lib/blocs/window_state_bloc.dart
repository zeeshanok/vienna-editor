import 'package:flutter_bloc/flutter_bloc.dart';

class WindowCubit extends Cubit<WindowState> {
  WindowCubit() : super(const NewWindowState());

  void setTo(WindowState state) => emit(state);
}

abstract class WindowState {}

class NewWindowState implements WindowState {
  const NewWindowState();
}

class RegularWindowState implements WindowState {
  final String title;
  const RegularWindowState(this.title);
}
