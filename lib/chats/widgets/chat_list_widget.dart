import 'package:authentication/chats/models/chat_model.dart';
import 'package:authentication/core/styles/colors.dart';
import 'package:authentication/core/styles/text_styles.dart';
import 'package:authentication/widgets/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../authentication/models/user_model.dart';
import '../screens/chats_screen.dart';

class ChatListWidget extends StatefulWidget{
  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();

  UserModel? user;
  ChatModel? chat;

  bool isChat;
  int index;
  Function(UserModel user) callback;

  ChatListWidget(this.index, {required this.isChat, required this.callback}){
    if(isChat){
      chat = ChatsScreenState.chats[index];
    }
    else{
      user = ChatsScreenState.users[index];
    }
  }
}

class _ChatListWidgetState extends State<ChatListWidget> {
  @override
  Widget build(BuildContext context) {
    if((widget.isChat && widget.index >= ChatsScreenState.chats.length) &&
      (!widget.isChat && widget.index >= ChatsScreenState.users.length)){
      return Container();
    }

    return GestureDetector(
        onTap: (){
          widget.callback(widget.chat!.users[0]!);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  width: 2,
                  color: Colors.grey.withOpacity(0.5)
              )
          ),
          child: Row(
            children: [
              Expanded(child: Container(),flex: 5,),
              Expanded(child: CircleCustomAvatar(context),flex: 20,),
              Expanded(child: Container(),flex: 3,),
              Expanded(child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container(),flex: 10,),
                    Expanded(child: Text(
                      widget.isChat ? widget.chat!.users[0].name : widget.user!.name,
                      style: medium_black(),),
                    flex: 20,),
                    Expanded(child: Container(),flex: 2,),
                    Expanded(child: Text(
                      widget.isChat ? widget.chat!.lastMessage : '',
                      style: small_black(),),
                    flex: 15,),
                    Expanded(child: Container(),flex: 10,)
                    //
                  ],
                ),
              ),flex: 60,),
              Expanded(child: Container(),flex: 3,),
            ],
          ),
        )
    );
  }
}