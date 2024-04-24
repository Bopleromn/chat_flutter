import 'package:authentication/chats/widgets/user_list_widget.dart';
import 'package:authentication/core/styles/field_styles.dart';
import 'package:authentication/core/styles/text_styles.dart';
import 'package:authentication/core/themes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: currentTheme.primaryColor
        ),
        automaticallyImplyLeading: false,
        title: Text('Чаты', style: large_black()),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            Expanded(child: Container(),flex: 3,),
            Expanded(child: Container(
              child: TextFormField(
                decoration: search_field_decoration('Найти'),
              ),
            ),flex: 7,),
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
}