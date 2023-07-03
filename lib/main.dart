import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kSchemeColor = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
var kDarkSchemeColor = ColorScheme.fromSeed(brightness: Brightness.dark,seedColor: const Color.fromARGB(255, 5, 99,125));

void main() {
  runApp(MaterialApp(
    darkTheme:  ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkSchemeColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkSchemeColor.primaryContainer)),
    ),
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kSchemeColor,
      appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kSchemeColor.onPrimaryContainer,
          foregroundColor: kSchemeColor.primaryContainer),
      cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: kSchemeColor.secondaryContainer),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kSchemeColor.primaryContainer)),
      // textTheme: TextTheme().copyWith(
      //   titleLarge: TextTheme().titleLarge.copyWith(fontWeight: FontWeight.normal,fontSize: 14)
      // )
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),
    ),
    themeMode: ThemeMode.system,
    home: const Expenses(),
  ));
}
