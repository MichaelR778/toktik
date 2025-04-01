import 'package:flutter/material.dart';

class AppTheme {
  static final appTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      inversePrimary: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      hintStyle: TextStyle(color: Colors.grey),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.black,
      indicatorColor: Colors.white,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    ),
    appBarTheme: AppBarTheme(centerTitle: false),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),
    ),
  );
}
