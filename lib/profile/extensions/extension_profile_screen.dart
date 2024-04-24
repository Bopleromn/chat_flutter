part of '../profile_screen.dart';

extension on _ProfileScreenState{
  void SetAllInformation (){
    emailcontroller.text = model.email;
    passwordlcontroller.text  = model.password;
    namecontroller.text = model.name;
  }
}