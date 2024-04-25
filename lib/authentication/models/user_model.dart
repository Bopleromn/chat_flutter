// ignore_for_file: unnecessary_this

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

import '../../core/globals.dart' as globals;

class UserModel{
  late String email;
  late String password;
  late String name;
  late int id;
  late String verificationCode;
  late String photo;


  UserModel(){}

  UserModel.filled({required this.id, required this.email, required this.name});

  Future<bool> authorize() async{
    try {
      final response = await Dio().get(
          'http://${globals.ip}/users?email=${this.email}&password=${this.password}'
      );

      final json = response.data as Map<String, dynamic>;

      this.id = json['data']['id'];
      this.email = json['data']['email'];
      this.password = json['data']['password'];
      this.name = json['data']['name'];
      this.photo = json['data']['photo'];

      return true;
    }
    catch (e){
      return false;
    }
  }

  Future<bool> register() async{
    final json = Map<String,dynamic>();

    json['email'] = this.email;
    json['password'] = this.password;
    json['name'] = this.name;
    json['age'] = 0;

    try {
      await Dio().post(
          'http://${globals.ip}/users', data: json
      );

      return true;
    }
    catch (e){
      return false;
    }
  }

  Future<bool> sendVerificationCode(bool isRegistration) async{
    try{
      await Dio().get(
          'http://${globals.ip}/users/verification_codes/send?email=${this.email}&is_registration=${isRegistration}'
      );

      return true;
    }
    catch (e){
      return false;
    }
  }

  Future<bool> checkVerificationCode() async{
    try {
      await Dio().get(
          'http://${globals.ip}/users/verification_codes/check?email=${this.email}&verification_code=${this.verificationCode}'
      );

      return true;
    }
    catch (e){
      return false;
    }
  }

  Future<bool> resetPassword() async{
    try {
      await Dio().get(
          'http://${globals.ip}/users/reset_password?email=${this.email}&new_password=${this.password}&verification_code=${this.verificationCode}'
      );

      return true;
    }
    catch (e){
      return false;
    }
  }

}