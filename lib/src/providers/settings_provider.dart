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
  void setThemeOverride(int value) {
    Color? backgroundColor;
    if (value == 1) {
      backgroundColor = const Color.fromARGB(255, 103, 189, 178);
    } else if (value == 2) {
      backgroundColor = const Color.fromARGB(255, 55, 30, 83);
    }

    state = state.copyWith(
      themeOverride: value,
      themeOverrideBackground: backgroundColor,
    );

    _saveSettings();
  }

  void _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeOverride', state.themeOverride);
  }

  int themeOverride() {
    return state.themeOverride;
  }

  Color? themeOverrideBackground() {
    return state.themeOverrideBackground;
  }
}
