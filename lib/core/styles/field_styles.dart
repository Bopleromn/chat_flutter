import 'package:authentication/core/styles/colors.dart';
import 'package:authentication/core/themes.dart';
import 'package:flutter/material.dart';

InputDecoration field_regular_decoration(String hint){
  return InputDecoration(
      border: OutlineInputBorder(),
      hintText: hint,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: currentTheme.primaryColor),
          borderRadius: BorderRadius.circular(10)
      )
  );
}

InputDecoration password_field_decoration(String hint, bool passwordVisible, Function() callback){
  return InputDecoration(
      border: OutlineInputBorder(),
      hintText: hint,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: currentTheme.primaryColor),
          borderRadius: BorderRadius.circular(10)
      ),
      suffixIcon: IconButton(
        icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off
        ),
        onPressed: callback,
      )
  );
}

BoxDecoration rounded_decoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: currentTheme.primaryColor
  );
}

InputDecoration search_field_decoration(String hint){
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      //borderSide: BorderSide.none
    ),
    filled: true,
    fillColor: Colors.transparent,
    hoverColor: Colors.transparent,
    hintStyle: TextStyle(fontSize: 18, color: Colors.grey.withOpacity(0.8)),
    hintText: hint,
    suffixIcon: Icon(
      Icons.search,
      color: Colors.grey.withOpacity(0.8),
    )
  );
}

InputDecoration filled_search_field_decoration(String hint){
  return InputDecoration(
    border: OutlineInputBorder(
      borderSide:BorderSide.none ,
      borderRadius: BorderRadius.circular(15)
    ),
    filled: true,
    fillColor: currentTheme.canvasColor,
    hoverColor: Colors.transparent,
    hintStyle: TextStyle(fontSize: 18, color: currentTheme.hintColor),
    hintText: hint,
    suffixIcon: Icon(
      Icons.search,
      color: currentTheme.hintColor,
    )
  );
}

InputDecoration field_profile_decoration(String hint, Icon icon){
  return InputDecoration(
      border: OutlineInputBorder(),
      hintText: hint,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: currentTheme.primaryColor),
          borderRadius: BorderRadius.circular(10)
      ),
      suffixIcon: icon,
  );
}