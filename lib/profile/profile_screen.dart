import 'package:authentication/authentication/models/user_model.dart';
import 'package:authentication/core/styles/field_styles.dart';
import 'package:authentication/core/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
part 'extensions/extension_profile_screen.dart';
class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel model = UserModel();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordlcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: const Color.fromARGB(255, 116, 165, 249),
        automaticallyImplyLeading: false,
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
                  controller: emailcontroller,
                  decoration: field_profile_decoration('Почта', Icon(Icons.email)),

                ),
                SizedBox(height: 2.h,),
                TextFormField(
                  controller: passwordlcontroller,
                  decoration: password_field_decoration('Пароль', passwordVisible, updatePasswordVisibility),
                  obscureText: passwordVisible,
                ),
                SizedBox(height: 2.h,),
                TextFormField(
                  controller: namecontroller,
                  decoration: field_profile_decoration('Имя', Icon(Icons.abc)),),
                SizedBox(height: 6.h,),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 116, 165, 249),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextButton.icon(onPressed: (){}, icon: Icon(Icons.share,color: Colors.white, ), label: Text('Сохранить',style: medium_white(),)),)
                
              ],
            ))
          ],
        ),
      ),
    );
  }

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