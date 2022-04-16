import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData.dark().copyWith(
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[800],
      filled: true,
      hintStyle: const TextStyle(fontSize: 17),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: Colors.transparent),
      ),
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.transparent,
        ),
      ),
    ),
  );
}
