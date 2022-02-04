import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:vienna_editor/models/window_tab_model.dart';

class WindowTabCubit extends Cubit<List<WindowTabModel>> {
  WindowTabCubit() : super([const WindowTabModel.newTab(selected: true)]);

  void closeTab(int index) {
    final newState = [...state];
    final sIndex = selectedIndex;
    newState.removeAt(index);
    if (newState.isEmpty) {
      emit([const WindowTabModel.newTab(selected: true)]);
    } else {
      if (index == sIndex) {
        emit([
          newState[0].asSelected(),
          ...newState.sublist(1).map((e) => e.asUnSelected())
        ]);
      } else {
        emit(newState);
      }
    }
  }

  void newTab([int? index]) {
    debugPrint("new tab");
    if (index == null) {
      emit([...state, const WindowTabModel.newTab(selected: false)]);
    } else {
      final newState = [...state];
      newState.insert(index, const WindowTabModel.newTab(selected: false));
      emit(newState);
    }
  }

  void makeTabSelected(int index) {
    final s = [...state];
    final newState = [
      for (var i = 0; i < s.length; i++)
        i == index ? s[i].asSelected() : s[i].asUnSelected()
    ];
    emit(newState);
  }

  int get selectedIndex {
    final s = [...state];
    for (var i = 0; i < s.length; i++) {
      if (s[i].selected) return i;
    }
    return -1;
  }
}
