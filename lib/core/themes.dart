import 'package:chat/core/styles/colors.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    primaryColor: Colors.green,
    secondaryHeaderColor: Colors.grey,
    canvasColor: Color(0xffF0F0F0),
    hintColor: Color(0xffD0D0D0),
    cardColor: Color(0xffF8F8F8),
    dividerColor: Colors.green,
    hoverColor: Colors.grey.withOpacity(0.2),
    iconTheme: IconThemeData(
      color: Colors.grey,
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.grey,
      color: Colors.white,
      elevation: 2,
      iconTheme: IconThemeData(
        color: Colors.black.withOpacity(0.6)
      )
    ),
    colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    brightness: Brightness.light,
    background: Colors.white,
    secondary: Colors.white,
    primary: Colors.green
  )
);

final darkTheme = ThemeData(
    primaryColor: Colors.green,
    secondaryHeaderColor: Colors.white10,
    canvasColor: Colors.white10,
    hintColor: Color(0xff101010),
    cardColor: Color(0xff202020),
    dividerColor: Colors.white10,
    hoverColor: Colors.grey.withOpacity(0.2),
    iconTheme: IconThemeData(
      color: Colors.white.withOpacity(0.6),
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.white10,
      backgroundColor: Colors.white10,
      elevation: 2,
      iconTheme: IconThemeData(
        color: Colors.white.withOpacity(0.6)
      )
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white10,
        brightness: Brightness.light,
        background: Colors.black,
        secondary: Colors.white10,
        primary: Colors.green
    )
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