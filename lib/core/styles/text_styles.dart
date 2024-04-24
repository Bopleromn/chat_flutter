import 'package:flutter/material.dart';

import '../themes.dart';

double smallFontSize = 14;
double mediumFontSize = 20;
double largeFontSize = 25;

// Primary color text styles

TextStyle small_primary(){
  return TextStyle(
    color: currentTheme.primaryColor,
    fontSize: smallFontSize,
    fontWeight: FontWeight.bold,
  );
}

TextStyle medium_primary(){
  return TextStyle(
    color: currentTheme.primaryColor,
    fontSize: mediumFontSize,
    fontWeight: FontWeight.bold,
  );
}

TextStyle large_primary(){
  return TextStyle(
    color: currentTheme.primaryColor,
    fontSize: largeFontSize,
    fontWeight: FontWeight.bold,
  );
}

// Secondary color text styles

TextStyle small_secondary(){
  return TextStyle(
    color: currentTheme.secondaryHeaderColor,
    fontSize: smallFontSize,
    fontWeight: FontWeight.bold,
  );
}

TextStyle medium_secondary(){
  return TextStyle(
    color: currentTheme.secondaryHeaderColor,
    fontSize: mediumFontSize,
    fontWeight: FontWeight.bold,
  );
}

TextStyle large_secondary(){
  return TextStyle(
    color: currentTheme.secondaryHeaderColor,
    fontSize: largeFontSize,
    fontWeight: FontWeight.bold,
  );
}

// Black text styles

TextStyle small_black(){
  return TextStyle(
    color: Colors.black,
    fontSize: smallFontSize,
    fontWeight: FontWeight.normal,
  );
}

TextStyle medium_black(){
  return TextStyle(
    color: Colors.black,
    fontSize: mediumFontSize,
    fontWeight: FontWeight.normal,
  );
}

TextStyle large_black(){
  return TextStyle(
    color: Colors.black,
    fontSize: largeFontSize,
    fontWeight: FontWeight.normal,
  );
}

// White text styles

TextStyle small_white(){
  return TextStyle(
    color: Colors.white,
    fontSize: smallFontSize,
    fontWeight: FontWeight.normal,
  );
}

TextStyle medium_white(){
  return TextStyle(
    color: Colors.white,
    fontSize: mediumFontSize,
    fontWeight: FontWeight.normal,
  );
}

TextStyle large_white(){
  return TextStyle(
    color: Colors.white,
    fontSize: largeFontSize,
    fontWeight: FontWeight.normal,
  );
}

// Grey text styles

TextStyle small_grey(){
  return TextStyle(
    color: Colors.grey,
    fontSize: smallFontSize,
    fontWeight: FontWeight.normal,
  );
}

TextStyle medium_grey(){
  return TextStyle(
    color: Colors.grey,
    fontSize: mediumFontSize,
    fontWeight: FontWeight.normal,
  );
}

TextStyle large_grey(){
  return TextStyle(
    color: Colors.grey,
    fontSize: largeFontSize,
    fontWeight: FontWeight.normal,
  );
}