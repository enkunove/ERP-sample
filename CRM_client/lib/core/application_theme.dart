import 'package:flutter/material.dart';

class ApplicationTheme{
  static ThemeData get theme{
    const primaryColor = Color(0xFF212517);
    const backgroundColor = Colors.white;
    const surfaceColor = Colors.white;
    const onPrimaryColor = Colors.white;
    const onSurfaceColor = Colors.black;
    const onBackgroundColor = Colors.black;
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF759242),
      hintColor: Colors.black,
      hoverColor: Colors.black,
      dividerColor: Colors.white,
      disabledColor: Colors.black,
      canvasColor: Color(0xFFF2F2EF),
      highlightColor: Colors.black,
      focusColor: Colors.black,
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.black,
          hoverColor: Colors.black,
          focusColor: Colors.black
      ),
      textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontFamily: 'MontserratAlternates',
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold),

      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF212517),
        textTheme: ButtonTextTheme.primary,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        secondary: primaryColor,
        onSecondary: onSurfaceColor,
        surface: surfaceColor,
        onSurface: onSurfaceColor,
        error: Colors.red,
        onError: Colors.white,
      ),
    );
  }
}