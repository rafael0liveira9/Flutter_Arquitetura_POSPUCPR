import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromARGB(255, 28, 46, 89);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color grey2Color = Color.fromARGB(255, 22, 22, 22);

  static TextTheme textTheme = const TextTheme(
    headline1: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    button: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: secondaryColor,
        background: Colors.black,
        brightness: Brightness.dark,
      ),
      textTheme: textTheme,
      buttonTheme: const ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
