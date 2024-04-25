import 'dart:typed_data';

import 'package:authentication/authentication/models/user_model.dart';
import 'package:authentication/core/styles/field_styles.dart';
import 'package:authentication/core/styles/text_styles.dart';
import 'package:authentication/helper/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
part 'extensions/extension_profile_screen.dart';
class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => ProfileScreenState(email: email, password:  password, name: username);
  late String username;
  late String password;
  late String email;
  ProfileScreen(
    {
      required this.email,
      required this.password,
      required this.username
    }
  );
}

class ProfileScreenState extends State<ProfileScreen> {
  Uint8List? image;


  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
    setState(() {
      
    });
  }
  ProfileScreenState({required this.email,required this.password,required this.name});
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordlcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
      @override
    void initState() {
      GetAllInfo();
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 2.h),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children:[
                    image == null ?
                  CircleAvatar(
                    backgroundImage:
                     NetworkImage('https://irecommend.ru/sites/default/files/product-images/1355960/FCtcXQX22GyEDWtOMIw.jpg'),
                    radius: 70,
                    
                  ) : CircleAvatar(backgroundImage: MemoryImage(image!),radius: 70,),
                  Positioned(child: IconButton(icon: Icon(Icons.add_a_photo), onPressed: (){selectImage();}), bottom: 10,left: 100,)
                  ]
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
                    child: TextButton.icon(onPressed: (){}, icon: Icon(Icons.save,color: Colors.white, ), label: Text('Сохранить',style: medium_white(),)),)
                  
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  bool passwordVisible = false, isChecked = false;
  late String name;
  late String email;
  late String password;
}