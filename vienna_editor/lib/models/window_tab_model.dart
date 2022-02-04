class WindowTabModel {
  final bool selected;
  final String? _name;
  String get name => _name ?? "New tab";
  WindowTabKind get kind =>
      _name == null ? WindowTabKind.newTab : WindowTabKind.regular;

  const WindowTabModel({required String? name, required this.selected})
      : _name = name;
  const WindowTabModel.newTab({required this.selected}) : _name = null;

  WindowTabModel asUnSelected() => WindowTabModel(name: _name, selected: false);
  WindowTabModel asSelected() => WindowTabModel(name: _name, selected: true);
}

enum WindowTabKind { newTab, regular }
