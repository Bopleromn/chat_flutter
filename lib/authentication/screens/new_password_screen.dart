import 'package:chat/authentication/bloc/authentication_event.dart';
import 'package:chat/core/styles/field_styles.dart';
import 'package:chat/core/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../models/user_model.dart';
import '../../widgets/loading_circle.dart';
import '../../widgets/snackbar.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_state.dart';

class NewPasswordScreen extends StatefulWidget{
  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  UserModel user = GetIt.I.get<UserModel>();

  AuthenticationBloc bloc = AuthenticationBloc(authenticationMethod.newPassword);

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
              Navigator.of(context).pushNamed('/AuthorizationScreen');
              showSnackBar(context, 'Пароль успешно обновлен');
            }
            else if(state is AuthenticationFailureState){
              Navigator.of(context).pop();
              showSnackBar(context, 'Не удалось обновить пароль');
            }
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: Container(), flex: 13,),
              Expanded(child: Text('Введите новый пароль',style: large_black(),) , flex: 3),
              Expanded(flex: 2,child: Text('Пароль', style: small_grey(),),),
              Expanded(flex: 6,child: TextField(
                controller: firstPasswordController,
                decoration: password_field_decoration('**********', passwordVisible, updatePasswordVisibility),
                obscureText: passwordVisible,
              )),
              Expanded(flex: 2,child: Text('Подтвердите пароль', style: small_grey()),),
              Expanded(flex: 7,child: TextField(
                controller: secondPasswordController,
                decoration: password_field_decoration('**********', passwordVisible, updatePasswordVisibility),
                obscureText: passwordVisible,
              )),
              Expanded(flex: 4,child: Container(
                  decoration: rounded_decoration(),
                  child:
                  TextButton(
                    onPressed: tryResetingPassword,child: Text('Сбросить пароль', style: small_white(),),) )),
              Expanded(child: Container(),flex: 18,)
            ],
          ),
        ),
      ),
    );
  }

  // Main functions

  void tryResetingPassword(){
    if(firstPasswordController.text != secondPasswordController.text){
      showSnackBar(context, 'Пароли должны совпадать');

      return;
    }
    else if(firstPasswordController.text.length < 5){
      showSnackBar(context, 'Длина пароля должна быть больше 4 символов');

      return;
    }

    user.password = firstPasswordController.text;

    bloc.add(AuthenticationEvent());
  }

  // Helpers

  TextEditingController firstPasswordController = TextEditingController(), secondPasswordController = TextEditingController();
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