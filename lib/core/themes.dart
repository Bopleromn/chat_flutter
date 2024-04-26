import 'package:authentication/core/styles/colors.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Colors.blueAccent,
  secondaryHeaderColor: Colors.orange,
  canvasColor: Color(0xffF5F5F5),
  hintColor: Color(0xffD0D0D0),
  cardColor: Color(0xffF8F8F8),
  dividerColor: Colors.blueAccent,
  hoverColor: Colors.grey.withOpacity(0.2),
  iconTheme: IconThemeData(
    color: Colors.grey,
  ),
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.white,
    shadowColor: Color.fromRGBO(0,27,59,1),
    color: Colors.white,
    elevation: 2,
  ), colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueAccent,
    brightness: Brightness.light,
    background: Colors.white,
    secondary: Colors.black,
    primary: Colors.blueAccent
  )
);

final darkTheme = ThemeData(
  primaryColor: const Color.fromARGB(255, 25, 57, 112),
  secondaryHeaderColor: Colors.orange,
  cardColor: const Color.fromARGB(255, 25, 57, 112),
);

ThemeData currentTheme = lightTheme;

void changeTheme(){
  if(currentTheme != lightTheme){
    currentTheme = lightTheme;
  }
  else{
    currentTheme = darkTheme;
  }
}