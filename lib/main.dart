import 'dart:io';

import 'package:authentication/authentication/models/user_model.dart';
import 'package:authentication/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:window_manager/window_manager.dart';

import 'authentication/screens/authorization_screen.dart';
import 'package:authentication/navigation/navigation_bar.dart' as _;
import 'core/routes.dart';
import 'core/themes.dart';

void main() async {
  _initSingletons();
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
     WindowManager.instance.setSize(Size(400, 800));
  }

  runApp(MyApp());
}

void _initSingletons() {
  GetIt.I.registerSingleton<UserModel>(UserModel());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  UserModel user = GetIt.I<UserModel>();

  bool isAuthorized = false;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: currentTheme,
        routes: myRoutes,
        home: isAuthorized ? _.NavigationBar(): AuthorizationScreen(),
      );
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    checkIfAuthorized();

    super.initState();
  }

  // Check if user uses remember me function
  void checkIfAuthorized() async{
    final sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString('email') != null && sharedPreferences.getString('password') != null){
      user.email = sharedPreferences.getString('email')!;
      user.password = sharedPreferences.getString('password')!;

      if(await user.authorize()){
        //isAuthorized = true;
      }
      else{
        isAuthorized = false;
        user.email = '';
        user.password = '';
      }

      setState(() {
        isAuthorized;
      });
    }
  }

  // Track user online or offline status
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if(state == AppLifecycleState.resumed){
      await GetIt.I<UserModel>().setLastSeen(true);
    }
    else if(state == AppLifecycleState.inactive ||
            state == AppLifecycleState.detached || state == AppLifecycleState.paused){
      await GetIt.I<UserModel>().setLastSeen(false);
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
}
