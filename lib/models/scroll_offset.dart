import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollOffset {
  int scrollOffsetValue;

  ScrollOffset({required this.scrollOffsetValue});

  ScrollOffset copyWith(int scrollOffsetValue) {
    return ScrollOffset(scrollOffsetValue: scrollOffsetValue);
  }
}

class DisplayOffset extends Cubit<ScrollOffset> {
  DisplayOffset(super.display);

  void changeDisplayOffset(int value) {
    emit(state.copyWith(value));
  }
}
