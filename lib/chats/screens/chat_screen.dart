import 'dart:async';
import 'dart:convert';
import 'package:authentication/chats/widgets/drop_down_button.dart';
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

part '../extensions/extension_chat_screeen.dart';
part '../widgets/message_bubble_widget.dart';

class ChatScreen extends StatefulWidget{
  @override
  State<ChatScreen> createState() => ChatScreenState(roomId: roomId, otherUser: otherUser);

  late int roomId;
  late UserModel otherUser;

  ChatScreen({required this.roomId, required this.otherUser});
}

enum chatState {loading, loaded, noMessages}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({required this.roomId, required this.otherUser});

  List<MessageModel> messages = [];
  var state = chatState.loading;

  @override
  void initState() {
    super.initState();

    _listenToStream();
    _initAllMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          otherUser.name!,
          style: medium_black(),
        ),
        actions: [
          drop_down_button(context, this),
        ],
      ),
      body: SafeArea(
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
                                message_bubble_widget(message, context)
                              ],
                            );
                          },
                        )
                      )
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        hintText: 'Введите сообщение',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _sendMessage();
                            _controller.text = '';
                          },
                          icon: Icon(Icons.send),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helpers

  // Function to clear messages from the other files(can be optimized)
  void clearAllMessages(){
    _clearAllMessages();
  }

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late WebSocketChannel _channel;
  late int roomId;
  late UserModel otherUser;

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