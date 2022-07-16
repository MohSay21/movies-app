import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>(
        (ref) => ThemeNotifier()
);

class ThemeNotifier extends StateNotifier<bool> {

  ThemeNotifier() : super(true);

  void changeTheme() {
    final newState = !state;
    state = newState;
  }

}

class MyTheme {

  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.grey.shade900,
      secondary: Colors.white,
    ),
    primaryColor: Colors.grey,
  );
  static final light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.white,
      secondary: Colors.black,
    ),
    primaryColor: Colors.grey,
  );

}