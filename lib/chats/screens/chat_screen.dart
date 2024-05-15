import 'dart:async';
import 'dart:convert';
import 'package:authentication/chats/widgets/custom_drop_down_menu.dart';
import 'package:authentication/core/styles/text_styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../authentication/models/user_model.dart';
import '../../core/globals.dart' as globals;
import '../../core/styles/colors.dart';
import '../../core/themes.dart';
import '../models/message_model.dart';
import '../widgets/message_bubble_widget.dart';

part '../extensions/extension_chat_screeen.dart';

class ChatScreen extends StatefulWidget{
  @override
  State<ChatScreen> createState() => ChatScreenState();

  late int roomId;
  late UserModel otherUser;
  Function() callBack;

  ChatScreen({required this.roomId, required this.otherUser, required this.callBack});
}

enum chatState {loading, loaded, noMessages}

class ChatScreenState extends State<ChatScreen> {
  List<MessageModel> messages = [];
  var state = chatState.loading;

  bool isEditing = false;
  MessageModel? editingMessage;

  @override
  void initState() {
    _listenToStream();
    _initAllMessages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.otherUser.name!,
              style: medium_black(),
            ),
            Padding(padding: EdgeInsets.only(top: 2)),
            Text(
              _parseLastSeen(widget.otherUser.lastSeen),
              style: widget.otherUser.lastSeen! == 'active'? small_primary().copyWith(fontWeight: FontWeight.normal) : small_grey()
            ),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: CustomDropdownMenu(
              menuItems: [MenuItem(text: 'Очистить чат', icon: CupertinoIcons.trash)],
              callback: (MenuItem item){
                if(item.text == 'Очистить чат'){
                  _clearAllMessages();
                }
              },
              child: Icon(
                Icons.list,
                size: 35,
              ),
            ),
          )
        ],
      ),
      body:
      PopScope(
        onPopInvoked: (_){
            widget.callBack();
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 8.0,
                bottom: 8.0
            ),
            child: Column(
              children: [
                Expanded(
                  child: state == chatState.loading ? Container() :
                        (state == chatState.noMessages ? Center(child: Text('Здесь пока нет сообщений', style: medium_grey(),)) :
                          ListView.builder(
                            itemCount: messages.length,
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              final message = messages[index];

                              return Row(
                                mainAxisAlignment: (message.userId == GetIt.I<UserModel>().id)
                                    ? MainAxisAlignment.start : (message.userId == 0 ? MainAxisAlignment.center : MainAxisAlignment.end),
                                children: [
                                  MessageBubbleWidget(
                                      context,
                                      message: message,
                                      onMessageEdited: (MessageModel message){
                                          editingMessage = message;
                                          _controller.text = message.message;
                                          setState(() {
                                            isEditing = true;
                                          });
                                      },
                                      onMessageDeleted: (MessageModel message) async{
                                        if(await message.delete()){

                                        }
                                      },
                                  )
                                ],
                              );
                            },
                          )
                        )
                ),
                Row(
                  children: [
                    Expanded(
                      child: isEditing ? Column(
                        children: [
                          MessageToEditWidget(),
                          EditField()
                        ],
                      )
                      : EditField()
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget EditField(){
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: light_grey().withOpacity(0.6),
        hoverColor: Colors.transparent,
        hintText: 'Введите сообщение',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: isEditing ? BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)) 
                                  : BorderRadius.circular(16)
        ),
        suffixIcon: IconButton(
          onPressed: () {
            _sendMessage();
            _controller.text = '';
          },
          icon: Icon(Icons.send),
        ),
      ),
    );
  }

  Widget MessageToEditWidget(){
    return  Container(
        width: MediaQuery.sizeOf(context).width,
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
        decoration: BoxDecoration(
            color: light_grey(),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16)
            )
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Редактировать сообщение', style: small_primary(),),
                Text(editingMessage!.message, style: small_black(),),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                setState(() {
                  isEditing = false;
                  _controller.text = '';
                });
              },
              child: Icon(Icons.close, color: Colors.black, size: 15,),
            )
          ],
        )
    );
  }

  // Helpers

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late WebSocketChannel _channel;

  String _parseLastSeen(String lastSeen){
    if(lastSeen == 'active') {
      return 'В сети';
    }

    DateTime parsed = DateTime.parse(lastSeen);

    return 'Был(-а) ' + ((parsed.day == DateTime.now().day) ? 'сегодня' :
            (parsed.day.toString().length == 1 ? '0' + parsed.day.toString() : parsed.day.toString()) + '.' +
            (parsed.month.toString().length == 1 ? '0' + parsed.month.toString() : parsed.month.toString())) +
            ' в ' + parsed.hour.toString() + ':' + (parsed.minute.toString().length == 1 ? '0' + parsed.minute.toString() : parsed.minute.toString());
  }

  void _scrollDown(){
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    _scrollController.dispose();

    super.dispose();
  }
}