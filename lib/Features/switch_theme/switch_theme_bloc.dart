import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final bool isDarkMode;

  ThemeChanged(this.isDarkMode);
}

// States
abstract class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);
}

class ThemeInitial extends ThemeState {
  ThemeInitial() : super(darkTheme);
}

class ThemeUpdated extends ThemeState {
  ThemeUpdated(super.themeData);
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeChanged>((event, emit) {
      emit(ThemeUpdated(event.isDarkMode ? darkTheme : lightTheme));
    });
  }
}

// Define Light and Dark Themes
final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.black);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black12,
  primaryColorDark: Colors.black12,
);
