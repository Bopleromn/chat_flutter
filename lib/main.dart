import 'package:authentication/authentication/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sizer/sizer.dart';

import 'authentication/screens/authorization_screen.dart';
import 'core/routes.dart';
import 'core/themes.dart';
import 'core/globals.dart' as globals;

void main() {
 _initSingletons();

 changeTheme();

  runApp(const MyApp());
}

void _initSingletons(){
  GetIt.I.registerSingleton<UserModel>(UserModel());
}

void changeTheme(){
  if(currentTheme != lightTheme){
    currentTheme = lightTheme;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
       builder: (context, orientation, deviceType){
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: currentTheme,
        routes: myRoutes,
        home: AuthorizationScreen(),
      );
    }
    );
  }
}