import 'package:chat/authentication/bloc/authentication_event.dart';
import 'package:chat/authentication/screens/verification_code_screen.dart';
import 'package:chat/core/styles/field_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/styles/text_styles.dart';
import '../models/user_model.dart';
import '../../widgets/loading_circle.dart';
import '../../widgets/snackbar.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_state.dart';

class EmailScreen extends StatefulWidget{
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  UserModel user = GetIt.I.get<UserModel>();

  AuthenticationBloc bloc = AuthenticationBloc(authenticationMethod.enterEmailAuthorization);

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
                MaterialPageRoute(builder: (context) => VerificationCodeScreen(authenticationMethod.authorization)));
            showSnackBar(context, 'Код отправлен вам на почту');
          }
          else if(state is AuthenticationFailureState){
            Navigator.of(context).pop();
            showSnackBar(context, 'Нет такого пользователя');
          }
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.fromLTRB(25, 180, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Забыли пароль?', style: large_black(),),
                  Text('Введите адрес почты', style: small_grey(),),
                  Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Почта', style: small_grey()),
                      Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                      TextField(
                          controller: _emailController,
                          decoration:field_regular_decoration('********@mail.com'))
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                  Container(
                      decoration: rounded_decoration(),
                      child:
                      TextButton(onPressed: trySendingEmail, child: Text('Отправить код подтверждения', style: small_white(),),)
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Помните пароль?', style: small_grey(),),
                      TextButton(onPressed: (){
                        Navigator.of(context).pushNamed('/AuthorizationScreen');
                      },
                        child: Text('Войдите', style: small_primary(),))
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  // Main functions

  void trySendingEmail(){
    user.email = _emailController.text;

    bloc.add(AuthenticationEvent());
  }

  // Helpers

  TextEditingController _emailController = TextEditingController();
}