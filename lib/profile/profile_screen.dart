import 'package:authentication/authentication/models/user_model.dart';
import 'package:authentication/core/styles/field_styles.dart';
import 'package:authentication/core/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

part 'extensions/extension_profile_screen.dart';

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => ProfileScreenState(user: user);

  UserModel user;

  ProfileScreen({required this.user});
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileScreenState({required this.user});

 UserModel user;

  @override
  void initState() {
    _getAllInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: const Color.fromARGB(255, 116, 165, 249),
        title: Text(
          'Профиль', style: large_white(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 2.h),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
              ),
            ),
            SizedBox(height: 3.h),
            Text('Основные данные о вас', style: medium_black(),),
            SizedBox(height: 3.h,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  readOnly: true,
                  controller: emailController,
                  decoration: field_profile_decoration('Почта', Icon(Icons.email)),

                ),
                SizedBox(height: 2.h,),
                TextFormField(
                  controller: passwordController,
                  decoration: password_field_decoration('Пароль', passwordVisible, _updatePasswordVisibility),
                  obscureText: passwordVisible,
                ),
                SizedBox(height: 2.h,),
                TextFormField(
                  controller: nameController,
                  decoration: field_profile_decoration('Имя', Icon(Icons.abc)),),
                SizedBox(height: 6.h,),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 116, 165, 249),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextButton.icon(onPressed: (){}, icon: Icon(Icons.save,color: Colors.white, ), label: Text('Сохранить',style: medium_white(),)),)
              ],
            ))
          ],
        ),
      ),
    );
  }

  TextEditingController passwordController = TextEditingController(), nameController = TextEditingController(),
                        emailController = TextEditingController();


  bool passwordVisible = false, isChecked = false;
}