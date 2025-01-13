import 'package:flutter/material.dart';

class Settings {
  final double fontSize;
  final int themeOverride;
  final Color? themeOverrideBackground;

  Settings({
    this.fontSize = 14.0,
    this.themeOverride = 0,
    this.themeOverrideBackground,
  });

  Settings copyWith({
    double? fontSize,
    int themeOverride = 0,
    Color? themeOverrideBackground,
  }) {
    return Settings(
      fontSize: fontSize ?? this.fontSize,
      themeOverride: themeOverride,
      themeOverrideBackground:
          themeOverrideBackground ?? this.themeOverrideBackground,
    );
  }
}
