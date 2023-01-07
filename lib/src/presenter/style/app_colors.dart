import 'package:flutter/material.dart';

class ColorMode {
  final Color light;
  final Color dark;

  const ColorMode({required this.light, required this.dark});
}

class AppColors {
  const AppColors._();

  static const ColorMode primary = ColorMode(
    light: Color(0xFF005AC2),
    dark: Color(0xFFADC6FF),
  );
  static const ColorMode onPrimary = ColorMode(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF002E6A),
  );
  static const ColorMode primaryContainer = ColorMode(
    light: Color(0xFFD8E2FF),
    dark: Color(0xFF004495),
  );
  static const ColorMode onPrimaryContainer = ColorMode(
    light: Color(0xFF001A42),
    dark: Color(0xFFD8E2FF),
  );
  static const ColorMode secondary = ColorMode(
    light: Color(0xFF825500),
    dark: Color(0xFFFFB950),
  );
  static const ColorMode onSecondary = ColorMode(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF452B00),
  );
  static const ColorMode secondaryContainer = ColorMode(
    light: Color(0xFFFFDDB3),
    dark: Color(0xFF633F00),
  );
  static const ColorMode onSecondaryContainer = ColorMode(
    light: Color(0xFF291800),
    dark: Color(0xFFFFDDB3),
  );
  static const ColorMode tertiary = ColorMode(
    light: Color(0xFF315CA9),
    dark: Color(0xFFAEC6FF),
  );
  static const ColorMode onTertiary = ColorMode(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF002E6A),
  );
  static const ColorMode tertiaryContainer = ColorMode(
    light: Color(0xFFD8E2FF),
    dark: Color(0xFF0F4490),
  );
  static const ColorMode onTertiaryContainer = ColorMode(
    light: Color(0xFF001A42),
    dark: Color(0xFFD8E2FF),
  );
  static const ColorMode error = ColorMode(
    light: Color(0xFFBA1A1A),
    dark: Color(0xFFFFB4AB),
  );
  static const ColorMode errorContainer = ColorMode(
    light: Color(0xFFFFDAD6),
    dark: Color(0xFF93000A),
  );
  static const ColorMode onError = ColorMode(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF690005),
  );
  static const ColorMode onErrorContainer = ColorMode(
    light: Color(0xFF410002),
    dark: Color(0xFFFFDAD6),
  );
  static const ColorMode background = ColorMode(
    light: Color(0xFFFEFBFF),
    dark: Color(0xFF1B1B1F),
  );
  static const ColorMode onBackground = ColorMode(
    light: Color(0xFF1B1B1F),
    dark: Color(0xFFE3E2E6),
  );
  static const ColorMode surface = ColorMode(
    light: Color(0xFFFEFBFF),
    dark: Color(0xFF1B1B1F),
  );
  static const ColorMode onSurface = ColorMode(
    light: Color(0xFF1B1B1F),
    dark: Color(0xFFE3E2E6),
  );
  static const ColorMode surfaceVariant = ColorMode(
    light: Color(0xFFE1E2EC),
    dark: Color(0xFF44474F),
  );
  static const ColorMode onSurfaceVariant = ColorMode(
    light: Color(0xFF44474F),
    dark: Color(0xFFC4C6D0),
  );
  static const ColorMode outline = ColorMode(
    light: Color(0xFF75777F),
    dark: Color(0xFF8E9099),
  );
  static const ColorMode onInverseSurface = ColorMode(
    light: Color(0xFFF2F0F4),
    dark: Color(0xFF1B1B1F),
  );
  static const ColorMode inverseSurface = ColorMode(
    light: Color(0xFF303034),
    dark: Color(0xFFE3E2E6),
  );
  static const ColorMode inversePrimary = ColorMode(
    light: Color(0xFFADC6FF),
    dark: Color(0xFF005AC2),
  );
  static const ColorMode shadow = ColorMode(
    light: Color(0xFF000000),
    dark: Color(0xFF000000),
  );
  static const ColorMode surfaceTint = ColorMode(
    light: Color(0xFF005AC2),
    dark: Color(0xFFADC6FF),
  );
}
