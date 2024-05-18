import 'package:chat/authentication/screens/email_screen.dart';
import 'package:chat/authentication/screens/verification_code_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/styles/field_styles.dart';
import '../../core/styles/text_styles.dart';
import '../../core/themes.dart';
import '../models/user_model.dart';
import '../../widgets/loading_circle.dart';
import '../../widgets/snackbar.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_event.dart';
import '../bloc/authentication_state.dart';

class AuthorizationScreen extends StatefulWidget{
  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  UserModel user = GetIt.I.get<UserModel>();

  AuthenticationBloc bloc = AuthenticationBloc(authenticationMethod.authorization);

  @override
  void initState(){
    super.initState();
  }

  void checkIfAuthorized() async{
    final sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString('email') != null && sharedPreferences.getString('password') != null){
      user.email = sharedPreferences.getString('email')!;
      user.password = sharedPreferences.getString('password')!;

      if(await user.authorize()){
        Navigator.of(context).pushNamed('/NavigationBar');
        showSnackBar(context, 'Вы успешно вошли');
      }
      else{
        user.email = '';
        user.password = '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: bloc,
        listener: (BuildContext context, AuthenticationState state) {
          if(state is AuthenticationLoadingState){
            showLoadingCircle(context);
          }
          else if(state is AuthenticationSuccessState){
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/ChatsScreen');
            showSnackBar(context, 'Вы успешно вошли');
          }
          else if(state is AuthenticationFailureState){
            Navigator.of(context).pop();
            showSnackBar(context, 'Неверный логин или пароль');
          }
        },
        child: Scaffold(
            body: Container(
              padding: EdgeInsets.fromLTRB(25, 170, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Добро пожаловать',
                    style: large_black(),
                  ),
                  Text(
                    'Введите почту и пароль, чтобы продолжить',
                    style: small_grey(),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
                  Text('Почта', style: small_grey()),
                  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                  TextField(
                    decoration: field_regular_decoration('Введите вашу почту'),
                    controller: emailController,
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
                  Text('Пароль', style: small_grey()),
                  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                  TextField(
                    decoration: password_field_decoration('Введите пароль', passwordVisible, updatePasswordVisibility),
                    obscureText: passwordVisible,
                    controller: passwordController,
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Container(
                      child: Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (newBool) {
                              setState(() {
                                isChecked = newBool!;
                              });
                            },
                            activeColor: currentTheme.primaryColor,
                          ),
                          Text(
                            'Запомнить меня',
                            style: small_grey(),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => EmailScreen()));
                        },
                        child: Text(
                          'Забыли пароль?',
                          style: small_primary(),
                        ))
                  ]),
                  Container(height: 5.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: rounded_decoration(),
                        child: TextButton(
                          onPressed: tryAuthorize,
                          child: Text('Войти', style: small_white()),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ещё нет аккаунта?',
                        style: small_grey(),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/RegistrationScreen');
                          },
                          child: Text(
                            'Зарегистрируйтесь',
                            style: small_primary(),
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
      );
  }

  // Main functions

  void tryAuthorize() async{
    if(emailController.text.toString().length < 5 || passwordController.text.toString().length < 4){
      showSnackBar(context, 'Данные введены некорректно');

      return;
    }

    user.email = emailController.text.toString();
    user.password = passwordController.text.toString();
    bloc.add(AuthenticationEvent());

    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    if(isChecked == true){
      sharedPreferences.setString('email', emailController.text.toString());
      sharedPreferences.setString('password', passwordController.text.toString());
    }
    else {
      sharedPreferences.remove('email');
      sharedPreferences.remove('password');
    }
  }

  // Helpers

  TextEditingController emailController = TextEditingController(), passwordController = TextEditingController();
  bool passwordVisible = false, isChecked = false;

  void updatePasswordVisibility(){
    if(passwordVisible == true){
      passwordVisible = false;
    }
    else{
      passwordVisible = true;
    }

    setState(() {
      passwordVisible;
    });
  }
}