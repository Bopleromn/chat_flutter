import 'package:authentication/chats/widgets/user_list_widget.dart';
import 'package:authentication/core/styles/field_styles.dart';
import 'package:authentication/core/styles/text_styles.dart';
import 'package:authentication/core/themes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/models/user_model.dart';
import '../../core/globals.dart' as globals;
import 'chat_screen.dart';

part '../extensions/extension_chats_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => ChatsScreenState();
}

class ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    initUsers();

    super.initState();
  }

  static List<UserModel> users = [];

  void initUsers() async {
    users = await initAllUsers();

    setState(() {
      users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: currentTheme.cardColor,
        child: Padding(
        padding: EdgeInsets.only(left: 3.w,right: 3.w,top: 10.h),
        child: Column(
          children: [
            CircleAvatar(backgroundColor: Colors.black,radius: 70,),
            SizedBox(height: 2.h,),
            Text('Alex', style: large_black(), textAlign: TextAlign.start,),
            SizedBox(child: Container(color: Colors.grey.withOpacity(0.7),),height: 2,),
            SizedBox(height: 2.h,),
            Container(
              height: 6.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 4
                  ),
                ],
                color: currentTheme.cardColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Темная тема', style: small_black(),),
                  CupertinoSwitch(value: isChecked!, onChanged: (newbool){
                     setState(() {
                              isChecked = newbool!;
                              changeTheme();
                              currentTheme;
                            });
                  })
                ],
              ),
            )
            
          ],
        ),
      ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        shadowColor: Colors.transparent,
        backgroundColor: const Color.fromARGB(255, 116, 165, 249),
        toolbarHeight: 6.h,
        title: Text('Чаты', style: large_white()),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            Expanded(child: Container(),flex: 3,),
            Expanded(child: Container(
              child: TextFormField(
                decoration: filled_search_field_decoration('Найти'),
              ),
            ),flex: 9,),
            Expanded(child: Container(),flex: 5,),
            Expanded(child:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15
                ),
                itemCount: 6,
                itemBuilder: users_list_widget
            ),flex: 85,)
          ],
        ),
      ),
    );
  }
  bool isChecked = false;
}