import 'package:chat/authentication/screens/email_screen.dart';
import 'package:chat/authentication/screens/new_password_screen.dart';
import 'package:chat/authentication/screens/verification_code_screen.dart';
import 'package:chat/chats/screens/chats_screen.dart';
import 'package:flutter/cupertino.dart';

import '../authentication/screens/authorization_screen.dart';
import '../authentication/screens/registration_screen.dart';

Map<String, Widget Function(BuildContext)> myRoutes = {
  '/AuthorizationScreen': (context) => AuthorizationScreen(),
  '/RegistrationScreen': (context) => RegistrationScreen(),
  '/EmailScreen': (context) => EmailScreen(),
  '/NewPasswordScreen': (context) => NewPasswordScreen(),
  '/ChatsScreen': (context) => ChatsScreen(),
};