import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class EchidnabitTheme {
  static const Color _brandBlue = Color(0xFF7AA2FF);
  static const Color _midnight = Color(0xFF0A1020);
  static const Color _surface = Color(0xFF10192F);
  static const Color _surfaceElevated = Color(0xFF15223D);
  static const Color _foreground = Color(0xFFF5F7FF);
  static const Color _mutedForeground = Color(0xFF98A7CC);
  static const Color _border = Color(0xFF243556);

  static final FThemeData dark = FThemes.blue.dark.touch.copyWith(
    colors: FThemes.blue.dark.touch.colors.copyWith(
      primary: _brandBlue,
      primaryForeground: _midnight,
      secondary: _surfaceElevated,
      secondaryForeground: _foreground,
      muted: _surface,
      mutedForeground: _mutedForeground,
      background: _midnight,
      foreground: _foreground,
      card: _surface,
      border: _border,
    ),
  );
}
