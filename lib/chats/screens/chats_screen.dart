import 'package:authentication/chats/widgets/chat_list_widget.dart';
import 'package:authentication/core/styles/field_styles.dart';
import 'package:authentication/core/styles/text_styles.dart';
import 'package:authentication/core/themes.dart';
import 'package:authentication/widgets/avatar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/models/user_model.dart';
import '../../core/globals.dart' as globals;
import '../models/chat_model.dart';
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
    initLists();

    super.initState();
  }

  static List<UserModel> users = [];
  static List<ChatModel> chats = [];


  void initLists() async {
    users = await UserModel.getAll();
    chats = await ChatModel.getAll(users);

    setState(() {
      chats;
      users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: currentTheme.colorScheme.background,
        child: Padding(
        padding: EdgeInsets.only(left: 3.w,right: 3.w,top: 10.h),
        child: Column(
          children: [
            CircleCustomAvatar(context),
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
        shadowColor: Colors.transparent,
        backgroundColor: currentTheme.colorScheme.background,
        title: Text('Чаты', style: medium_black()),
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
                itemCount: users.length,
                itemBuilder: (context, index){
                  return ChatListWidget(
                    index,
                    callback: (user) => _goToChat(user),
                    isChat: false,);
                }
            ),flex: 85)
          ],
        ),
      ),
    );
  }
  bool isChecked = false;
}