import 'package:flutter/material.dart';

class MyThemeData {
  static const Color primaryLightColor = Color(0xFF121312);
  static const Color greyDarkColor = Color(0xFF1A1A1A);
  static const Color greyColor = Color(0xFF282A28);
  static const Color whiteColor = Colors.white;
  static const Color yellowColor = Color(0xFFFFBB3B);

  static ThemeData Themes = ThemeData(
    appBarTheme: const AppBarTheme(
        backgroundColor: greyDarkColor,
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        centerTitle: true,
        titleSpacing: 2,
        titleTextStyle: TextStyle(color: Colors.white)),
    scaffoldBackgroundColor: primaryLightColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: greyDarkColor, // Set the background color here
      selectedItemColor: yellowColor,
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(size: 32, color: yellowColor),
    ),
    colorScheme: ColorScheme.fromSeed(
      background: primaryLightColor,
      seedColor: Colors.black,
      primary: greyColor,
      secondary: greyDarkColor,
      onPrimary: whiteColor,
      onSecondary: Colors.white,
    ),
    useMaterial3: true,
  );
}
