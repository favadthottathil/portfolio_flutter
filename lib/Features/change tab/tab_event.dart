// Create events for your TabBloc that handle user actions like changing tabs.

abstract class TabEvent {}

class TabChanged extends TabEvent {
  final int index;

  TabChanged(this.index);
}
