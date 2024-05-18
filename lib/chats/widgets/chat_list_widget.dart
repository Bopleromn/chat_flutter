import 'package:chat/chats/models/chat_model.dart';
import 'package:chat/core/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/models/user_model.dart';
import '../screens/chats_screen.dart';
import '../../core/globals.dart' as globals;

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
      user = ChatsScreenState.selectedUsers[index];
    }
  }
}

class _ChatListWidgetState extends State<ChatListWidget> {
  @override
  Widget build(BuildContext context) {
    if((widget.isChat && widget.index >= ChatsScreenState.chats.length) &&
      (!widget.isChat && widget.index >= ChatsScreenState.selectedUsers.length)){
      return Container();
    }

    var user = widget.isChat ? widget.chat!.users[0]! : widget.user!;

    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: InkWell(
            onTap: (){
              widget.callback(user);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      width: 2,
                      color: Colors.grey.withOpacity(0.5)
                  )
              ),
              child: Row(
                children: [
                  Expanded(child: Container(),flex: 5,),
                  Container(
                    padding: EdgeInsets.all(3),
                    height: 20.h,
                    width: 20.w,
                    child:  CircleAvatar(
                      backgroundImage: user.photo.length == 0 ? NetworkImage('https://qph.cf2.quoracdn.net/main-qimg-6d72b77c81c9841bd98fc806d702e859-lq') :
                      NetworkImage('http://${globals.ip}/images?name=${user.photo}'),
                    ),
                  ),
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
                          style: small_grey(),),
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
        )
    );
  }
}