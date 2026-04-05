import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

class EchidnabitTheme {
  static const Color _brandBlue = Color(0xFF3454D1);
  static const Color _softBlue = Color(0xFFEAF0FF);
  static const Color _mist = Color(0xFFF7F8FC);
  static const Color _mistForeground = Color(0xFF667085);
  static const Color _border = Color(0xFFD8E0F2);

  static final FThemeData light = FThemes.blue.light.touch.copyWith(
    colors: FThemes.blue.light.touch.colors.copyWith(
      primary: _brandBlue,
      primaryForeground: const Color(0xFFFFFFFF),
      secondary: _softBlue,
      secondaryForeground: _brandBlue,
      muted: _mist,
      mutedForeground: _mistForeground,
      card: const Color(0xFFFFFFFF),
      border: _border,
    ),
  );
}
