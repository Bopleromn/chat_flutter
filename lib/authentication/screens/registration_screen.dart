import 'package:authentication/authentication/screens/email_screen.dart';
import 'package:authentication/authentication/screens/verification_code_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/styles/field_styles.dart';
import '../../core/styles/text_styles.dart';
import '../models/user_model.dart';
import '../../widgets/loading_circle.dart';
import '../../widgets/snackbar.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_event.dart';
import '../bloc/authentication_state.dart';

class RegistrationScreen extends StatefulWidget{
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  UserModel user = GetIt.I.get<UserModel>();

  AuthenticationBloc bloc = AuthenticationBloc(authenticationMethod.enterEmailRegistration);

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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VerificationCodeScreen(authenticationMethod.registration)));
            showSnackBar(context, 'Код отправлен вам на почту');
          }
          else if(state is AuthenticationFailureState){
            Navigator.of(context).pop();
            showSnackBar(context, 'Не удалось зарегистрироваться');
          }
        },
        child: Scaffold(
            body: Container(
              padding: EdgeInsets.fromLTRB(25, 90, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Создайте аккаунт',
                      style: large_black()),
                  Text('Заполните поля, чтобы зарегистрироваться',
                      style: small_grey()),
                  Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Имя', style: small_grey()),
                      Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                      TextField(
                          controller: _nameController,
                          decoration: field_regular_decoration('Введите имя'))
                    ],
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Почта', style: small_grey()),
                      Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                      TextField(
                          controller: _emailController,
                          decoration: field_regular_decoration('********@***.**'))
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Пароль', style: small_grey()),
                      Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                      TextField(
                        controller: _firstPasswordController,
                        decoration: password_field_decoration('*******', passwordVisible, updatePasswordVisibility),
                        obscureText: passwordVisible,
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Потвердите пароль', style: small_grey()),
                      Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                      TextField(
                        controller: _secondPasswordController,
                        decoration: password_field_decoration('*******', passwordVisible, updatePasswordVisibility),
                        obscureText: passwordVisible,
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (newBool) {
                              setState(() {
                                isChecked = newBool!;
                              });
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('Нажимая на эту кнопку, вы соглашаетесь с ',
                              style: small_grey()),
                          Text('нашей политикой конфиденциальности', style: small_secondary()),
                            ],
                          )
                        ],
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  Container(
                    decoration: rounded_decoration(),
                    height: 50,
                    child: TextButton(
                      onPressed: tryRegister,
                      child: Text('Зарегистрироваться', style: small_white()),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Уже есть аккаунт? ', style: small_grey()),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/AuthorizationScreen');
                          },
                          child: Text(
                            'Войти',
                            style: small_primary(),
                          ))
                    ],
                  ),
                ],
              ),
            )
        ),
    );
  }

  // Main functions

  void tryRegister(){
    if (_firstPasswordController.text.toString() != _secondPasswordController.text.toString()) {
      showSnackBar(context, 'Введите одинаковые пароли');

      return;
    }

    if(_firstPasswordController.text.toString().length < 5){
      showSnackBar(context, 'Длина пароля должна быть больше 4');

      return;
    }

    if(_emailController.text.toString().length < 5 ||
        !RegExp(r'^[\w]{1,15}@[a-zA-Z]{2,5}\.[A-Za-z]{2,5}$').hasMatch(_emailController.text.toString())){
      showSnackBar(context, 'Неверный формат почты');

      return;
    }

    if(_nameController.text.toString().length < 4){
      showSnackBar(context, 'Длина имени должна быть больше 3 симмволов');

      return;
    }

    user.email = _emailController.text.toString();
    user.password = _firstPasswordController.text.toString();
    user.name = _nameController.text.toString();

    bloc.add(AuthenticationEvent());
  }

  // Helper functions

  bool passwordVisible = false, isChecked = false;
  // ignore: prefer_final_fields
  TextEditingController _emailController = TextEditingController(), _firstPasswordController = TextEditingController(), _secondPasswordController = TextEditingController(),
  _nameController = TextEditingController(), _phoneNumberController = TextEditingController();

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