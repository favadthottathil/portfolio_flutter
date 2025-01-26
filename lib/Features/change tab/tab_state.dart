// The state should hold the current active tab index.

abstract class TabState {}

class TabInitial extends TabState {
  final int index;

  TabInitial({this.index = 0});
}

class TabUpdated extends TabState {
  final int index;

  TabUpdated(this.index);
}
// The event should be used to change the active tab index.