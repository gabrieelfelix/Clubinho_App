import 'package:flutter/material.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
}

// extension CustomColors on ColorScheme {
//   Color get shadowGrey => const Color(0xFF9E9E9E).withOpacity(0.2);
// }

class GlobalThemeData {
  // static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData = themeData(lightColorScheme);

  //  static ThemeData lightThemeData =
  //     themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      // highlightColor: Colors.transparent,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF4D975B),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF000000),
    tertiary: Color(0xFF0000FF),
    error: Colors.redAccent,
    onError: Color(0xFFFFFFFF),
    background: Color(0xFFE6EBEB),
    onBackground: Color(0xFFE6EBEB),

    // surface: Color(0xFF808080),
    surface: Color(0xFF9E9E9E),
    onSurface: Color(0xFF3A3D90),
    brightness: Brightness.light,
  );
}
