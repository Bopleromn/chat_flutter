import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../models/user_model.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

enum authenticationMethod {
  authorization,
  registration,
  enterEmailRegistration,
  enterEmailAuthorization,
  verificationCode,
  newPassword
}

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(authenticationMethod method) : super(AuthenticationInitialState()) {
    this.method = method;

    on<AuthenticationEvent>((AuthorizationEvent, AuthorizationState) async{
      emit(AuthenticationLoadingState());

      UserModel user = GetIt.I.get<UserModel>();
      late bool response;

      switch(this.method){
        case authenticationMethod.authorization:
          response = await user.authorize();

          break;
        case authenticationMethod.registration:
          response = await user.register();

          break;
        case authenticationMethod.enterEmailRegistration:
          response = await user.sendVerificationCode(true);

          break;
        case authenticationMethod.enterEmailAuthorization:
          response = await user.sendVerificationCode(false);

          break;
        case authenticationMethod.verificationCode:
          response = await user.checkVerificationCode();

          break;
        case authenticationMethod.newPassword:
          response = await user.resetPassword();

          break;
        default:
          emit(AuthenticationFailureState());

          break;
      }

      response ? emit(AuthenticationSuccessState()) : emit(AuthenticationFailureState());
    });
  }

  late authenticationMethod method;
}
