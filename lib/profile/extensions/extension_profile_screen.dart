part of '../profile_screen.dart';

extension on _ProfileScreenState{
  void GetAllInfo () async{
    setState(() {
    emailcontroller.text = email;
    passwordlcontroller.text  = password;
    namecontroller.text = name;
    });
  }
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
  void SaveAllInfo(){

  }
}