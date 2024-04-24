import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Colors.blueAccent,
  secondaryHeaderColor: Colors.orange,
  cardColor: Colors.white,
  canvasColor: Colors.white,
  dividerColor: Colors.blueAccent,
  hoverColor: Colors.grey.withOpacity(0.2),
  iconTheme: const IconThemeData(
    color: Colors.grey,
  ),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.white,
    shadowColor: Color.fromRGBO(0,27,59,1),
    color: Colors.white,
    elevation: 2,
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.light,).copyWith(background: Colors.white),
);

late ThemeData currentTheme = ThemeData();