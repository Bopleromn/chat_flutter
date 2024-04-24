import 'package:authentication/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'authentication/screens/authorization_screen.dart';
import 'core/routes.dart';
import 'core/themes.dart';

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
    return MaterialApp(
      theme: currentTheme,
      home: AuthorizationScreen(),
      routes: myRoutes,
    );
  }
}