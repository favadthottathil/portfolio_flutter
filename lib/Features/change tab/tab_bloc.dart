import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/Features/change%20tab/tab_state.dart';

import 'tab_event.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial()) {
    on<TabChanged>((event, emit) {
      emit(TabUpdated(event.index));
    });
  }
}
