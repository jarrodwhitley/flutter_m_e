import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:m_e/src/models/settings.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier() : super(Settings());

  // When theme is overridden, the background color of the app bar is set to this color
  // If the value is 0 then the theme is set to auto (following the time of day)
  void setcolorThemeOverride(int value) {
    Color? backgroundColor;

    if (value == 1) {
      backgroundColor = const Color.fromARGB(255, 103, 189, 178);
    } else if (value == 2) {
      backgroundColor = const Color.fromARGB(255, 55, 30, 83);
    }

    state = state.copyWith(
      colorThemeOverride: value,
      colorThemeOverrideBackground: backgroundColor,
    );

    _saveSettings();
  }

  void setReadercolorThemeOverride(int value) {
    Color? readerTextColor;
    Color? readerBackgroundColor;

    if (value == 1) {
      readerTextColor = Colors.black;
      readerBackgroundColor = Colors.white;
    } else if (value == 2) {
      readerTextColor = Colors.white;
      readerBackgroundColor = const Color.fromARGB(255, 36, 19, 54);
    }

    state = state.copyWith(
      readercolorThemeOverride: value,
      readerTextColor: readerTextColor,
      readerBackgroundColor: readerBackgroundColor,
    );

    _saveSettings();
  }

  void _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('colorThemeOverride', state.colorThemeOverride);
    await prefs.setInt(
        'readercolorThemeOverride', state.readercolorThemeOverride);
  }

  int colorThemeOverride() {
    return state.colorThemeOverride;
  }

  Color? colorThemeOverrideBackground() {
    return state.colorThemeOverrideBackground;
  }

  int readerThemeOverride() {
    return state.readercolorThemeOverride;
  }

  Color? readerTextColor() {
    return state.readerTextColor;
  }

  Color? readerBackgroundColor() {
    return state.readerBackgroundColor;
  }
}
