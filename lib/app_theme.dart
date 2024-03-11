import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme(bool isDark) {
    if (!isDark) {
      return ThemeData(
          cardColor: Colors.white,
          fontFamily: 'Inter',
          brightness: Brightness.light,
          appBarTheme: AppBarTheme(
            color: Colors.pink.shade100,
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'TitleFont',
              color: Colors.red,
              fontSize: 25,
            ),
          ),
          shadowColor: Colors.pink.withOpacity(0.15),
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            titleLarge: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            titleSmall: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w200,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink.shade50,
            foregroundColor: Colors.pink.shade900,
          )));
    }
    return ThemeData(
        cardColor: Colors.grey.shade800,
        fontFamily: 'Inter',
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'TitleFont',
            color: Colors.red,
            fontSize: 25,
          ),
        ),
        shadowColor: Colors.red.withOpacity(0.15),
        textTheme: const TextTheme(
            titleMedium: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            titleLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            titleSmall: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.withOpacity(0.2),
          foregroundColor: Colors.red,
        )));
  }
}
