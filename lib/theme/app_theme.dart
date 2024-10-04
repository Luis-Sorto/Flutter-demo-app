import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xFFEF9753);
  static const secondaryColor = Colors.blueGrey;

  static final theme = ThemeData(
    // Primary color
    primaryColor: primaryColor,

    // Chips
    chipTheme: ChipThemeData(
      showCheckmark: false,
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      labelStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      selectedColor: secondaryColor,
      side: const BorderSide(color: secondaryColor),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
      ),
    )),

    toggleButtonsTheme: const ToggleButtonsThemeData(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      constraints: BoxConstraints(
        minHeight: 40.0,
        minWidth: 40.0,
      ),
    ),

    // FloatingActionButton
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),

    // Text themes
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        height: 1,
      ),
      labelMedium: TextStyle(
        fontSize: 14.0,
        color: secondaryColor,
        height: 1,
      ),
      labelSmall: TextStyle(
        fontSize: 13,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
        color: secondaryColor,
        height: 1,
      ),
    ),

    // Icons
    iconTheme: const IconThemeData(
      color: secondaryColor,
    ),

    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          backgroundColor: Colors.grey),
    ),

    primaryIconTheme: const IconThemeData(
      color: secondaryColor,
    ),

    // InputDecoration Theme
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: secondaryColor)),
      suffixIconColor: secondaryColor,
      prefixIconColor: secondaryColor,
      outlineBorder: BorderSide(color: secondaryColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondaryColor),
      ),
      focusColor: secondaryColor,
      floatingLabelStyle: TextStyle(color: secondaryColor),
      hintStyle: TextStyle(color: secondaryColor),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    ),
  );
}
