import 'package:chat/authentication/bloc/authentication_event.dart';
import 'package:chat/core/styles/field_styles.dart';
import 'package:chat/core/styles/text_styles.dart';
import '../models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../widgets/loading_circle.dart';
import '../../widgets/snackbar.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_state.dart';

class VerificationCodeScreen extends StatefulWidget{
  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState(previousScreen);

  VerificationCodeScreen(authenticationMethod previousScreen){
    this.previousScreen = previousScreen;
  }

  late authenticationMethod previousScreen;
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  UserModel user = GetIt.I.get<UserModel>();

  AuthenticationBloc bloc = AuthenticationBloc(authenticationMethod.verificationCode);

  late authenticationMethod previousScreen;

  _VerificationCodeScreenState(authenticationMethod previousScreen){
    this.previousScreen = previousScreen;
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

          if (previousScreen == authenticationMethod.registration){
            if(bloc.method != authenticationMethod.registration){
              bloc.method = authenticationMethod.registration;
              bloc.add(AuthenticationEvent());
            }
            else{
              Navigator.of(context).pushNamed('/AuthorizationScreen');
              showSnackBar(context, 'Вы успешно зарегистрировались');
            }
          }
          else if(previousScreen == authenticationMethod.authorization){
            Navigator.of(context).pushNamed('/NewPasswordScreen');
            showSnackBar(context, 'Код введен верно');
          }
        }
        else if(state is AuthenticationFailureState){
          Navigator.of(context).pop();

          if(previousScreen == authenticationMethod.registration){
            Navigator.of(context).pop();
            showSnackBar(context, 'Не удалось зарегистрироваться');
          }
          else{
            showSnackBar(context, 'Код введен некорректно');
          }
        }
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 30, child: Container()),
                Expanded(flex: 5,child: Text('Подтведите код', style: large_black(),)),
                Expanded(flex: 5,child: Text('Вам на почту был отправлен 6 значный код', style: small_grey(),)),
                Expanded( flex: 3,child: Container()),
                Expanded(flex: 10,child:
                Form(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                            else if(value.length == 0 ){
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: _pin1,
                          style: medium_black(),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: field_regular_decoration(''),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                            else if(value.length == 0 ){
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: _pin2,
                          style: medium_black(),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: field_regular_decoration(''),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                            else if(value.length == 0 ){
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: _pin3,
                          style: medium_black(),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: field_regular_decoration(''),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                            else if(value.length == 0 ){
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: _pin4,
                          style: medium_black(),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: field_regular_decoration(''),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                            else if(value.length == 0 ){
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: _pin5,
                          style: medium_black(),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: field_regular_decoration(''),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: TextFormField(
                          onChanged: (value){
                            if(value.length == 1){
                              FocusScope.of(context).nextFocus();
                            }
                            else if(value.length == 0 ){
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          controller: _pin6,
                          style: medium_black(),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: field_regular_decoration(''),
                        ),
                      ),
                    ]),)
                ),
                Expanded(child: Container(),flex: 4,),

                Expanded(flex: 10, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: rounded_decoration(),
                      child: TextButton(onPressed: tryCheckingVerificationCode, child: Text('Подтвердить' , style: small_white(),)),
                    )
                  ],
                )),
                Expanded(flex :15 ,child:  Container()),
                Expanded(flex: 25, child:  Container())
              ]
          ),
        ),
      )
    );
  }

  // Main functions

  Future<void> tryCheckingVerificationCode() async {
    user.verificationCode = _pin1.text + _pin2.text + _pin3.text +
                            _pin4.text + _pin5.text + _pin6.text;

    bloc.add(AuthenticationEvent());
  }

  // Helpers

  TextEditingController _pin1 = TextEditingController(), _pin2 = TextEditingController(), _pin3 = TextEditingController(),
    _pin4 = TextEditingController(),  _pin5 = TextEditingController(), _pin6 = TextEditingController();
}