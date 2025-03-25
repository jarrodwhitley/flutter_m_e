import 'package:flutter/material.dart';

class Settings {
  final double fontSize;
  final int colorThemeOverride;
  final Color? colorThemeOverrideBackground;
  final int readercolorThemeOverride;
  final Color? readerTextColor;
  final Color? readerBackgroundColor;

  Settings({
    this.fontSize = 14.0,
    this.colorThemeOverride = 0,
    this.colorThemeOverrideBackground,
    this.readercolorThemeOverride = 0,
    this.readerTextColor,
    this.readerBackgroundColor,
  });

  Settings copyWith({
    double? fontSize,
    int colorThemeOverride = 0,
    Color? colorThemeOverrideBackground,
    int readercolorThemeOverride = 0,
    Color? readerTextColor,
    Color? readerBackgroundColor,
  }) {
    return Settings(
      fontSize: fontSize ?? this.fontSize,
      colorThemeOverride: colorThemeOverride,
      colorThemeOverrideBackground:
          colorThemeOverrideBackground ?? this.colorThemeOverrideBackground,
      readercolorThemeOverride: readercolorThemeOverride,
      readerTextColor: readerTextColor ?? this.readerTextColor,
      readerBackgroundColor:
          readerBackgroundColor ?? this.readerBackgroundColor,
    );
  }
}
