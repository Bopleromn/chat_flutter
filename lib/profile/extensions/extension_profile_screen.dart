part of '../profile_screen.dart';

extension on ProfileScreenState{
  void _getAllInfo () {
    emailController.text = user.email;
    passwordController.text  = user.password;
    nameController.text = user.name;
  }

  void _updatePasswordVisibility(){
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

  void _saveAllInfo(){
    final usermodel = GetIt.I<UserModel>();
  }
}