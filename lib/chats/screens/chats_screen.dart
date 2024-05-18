import 'dart:ui';

import 'package:chat/chats/widgets/chat_list_widget.dart';
import 'package:chat/core/styles/field_styles.dart';
import 'package:chat/core/styles/text_styles.dart';
import 'package:chat/core/themes.dart';
import 'package:chat/helpers/image.dart';
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
part '../widgets/drawer_widget.dart';

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

  static List<UserModel> users = [], selectedUsers = [];
  static List<ChatModel> chats = [];

  UserModel user = GetIt.I<UserModel>();

  void initLists() async {
    users = await UserModel.getAll();
    selectedUsers = users;
    chats = await ChatModel.getAll(selectedUsers);

    setState(() {
      chats;
      users;
    });
  }

  bool _isChat = true, _isDarkTheme = false;
  TextEditingController _searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer_widget(),
      onDrawerChanged: (bool isOpen) async{
        if(!isOpen){
          await user.update();
        }
      },
      appBar: AppBar(
        // backgroundColor: currentTheme == lightTheme ? currentTheme.colorScheme.background :
        //                                               Colors.white10,
        title: Text('Чаты', style: medium_black()),
        centerTitle: true,
        iconTheme: IconThemeData(color: medium_black().color!.withOpacity(0.6)),
      ),
      body: Container(
        color: currentTheme.colorScheme.background,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Expanded(child: Container(), flex: 3,),
            Expanded(child: Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: TextFormField(
                controller: _searchFieldController,
                onChanged: _search,
                decoration: filled_search_field_decoration('Найти'),
              ),
            ),flex: 9,),
            Expanded(child: Container(),flex: 3,),
            Expanded(child:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15
                ),
                itemCount: _isChat ? chats.length : selectedUsers.length,
                itemBuilder: (context, index){
                  return ChatListWidget(
                    index,
                    callback: (user) => _goToChat(user),
                    isChat: _isChat,
                  );
                }
            ),flex: 85)
          ],
        ),
      ),
    );
  }
}