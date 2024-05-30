// ignore_for_file: unnecessary_this

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../core/globals.dart' as globals;

class UserModel{
  late String email;
  late String password;
  late String name;
  late int id;
  late String verificationCode;
  late String photo;
  late String lastSeen;

  UserModel(){}

  UserModel.filled({required this.id, required this.email, required this.name, required this.lastSeen, required this.photo});

  static Future<List<UserModel>> getAll() async {
    try {
      final response = await Dio().get(
          'http://${globals.ip}/users/all'
      );

      final data = (response.data as Map<String, dynamic>)['data'] as List<dynamic>;

      List<UserModel> users = [];

      data.forEach((user) {
        UserModel userToAdd = UserModel.filled(
            id: user['id'],
            email: user['email'],
            name: user['name'],
            lastSeen: user['last_seen'],
            photo: user['photo'] == null ? '' : user['photo']
        );

        if (userToAdd.id != GetIt.I<UserModel>().id) {
          users.add(userToAdd);
        }
      });

      return users;
    }
    catch (_){
      return [];
    }
  }

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
      this.photo = json['data']['photo'] == null ? '' : json['data']['photo'];

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

  Future<bool> update() async{
    final json = Map<String,dynamic>();

    json['email'] = this.email;
    json['password'] = this.password;
    json['name'] = this.name;
    json['last_seen'] = 'active';
    json['photo'] = this.photo;
    json['age'] = 0;

    try {
      await Dio().put(
          'http://${globals.ip}/users?email=${this.email}&password=${this.password}', data: json
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

  Future<void> setLastSeen(bool isActive) async{
    try{
      await Dio().post(
        'http://${globals.ip}/users/activity?user_id=${this.id}&is_active=${isActive}'
      );
    }
    catch (e){}
  }

  Future<void> getLastSeen() async {
    try {
      var response = await Dio().get(
          'http://${globals.ip}/users/activity?user_id=${this.id}'
      );

      this.lastSeen = (response.data as Map<String, dynamic>)['data'];
    }
    catch (e) {
      print(e);
    }
  }
}