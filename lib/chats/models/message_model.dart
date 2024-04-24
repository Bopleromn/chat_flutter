import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/globals.dart' as globals;

class MessageModel{
  int userId;
  String message;
  DateTime sentAt;

  MessageModel({required this.userId, required this.message, required this.sentAt});

  static Future<List<MessageModel>> getAllMessages(int roomId) async{
    List<MessageModel> messages = [];

    var response = await Dio().get(
        'http://${globals.ip}/chats/$roomId'
    );

    //

    List<dynamic> data = (response.data as Map<String, dynamic>)['data'];

    data.forEach((msg) async {
      if(msg['message'].toString().length > 0) {
        MessageModel message = MessageModel(userId: msg['user_id'], message: msg['message'], sentAt: DateTime.parse(msg['created_at']));

        await addDate(messages, message);
        messages.add(message);
      }
    });

    return messages;
  }

  static Future<void> addDate(List<MessageModel> messages, MessageModel message) async{
    bool canAdd = true;
    messages.forEach((element) {
      if(element.sentAt.day == message.sentAt.day){
        canAdd = false;
        return;
      }
    });

    if(!canAdd){
      return;
    }

    var date = message.sentAt.day.toString() + ' ' + message.sentAt.month.toString();

    messages.add(MessageModel(userId: 0, message: date, sentAt: message.sentAt));
  }

  static Future<bool> clearAllMessages(int roomId) async{
    try {
      var response = await Dio().delete(
          'http://${globals.ip}/chats/$roomId'
      );

      return true;
    }
    catch (e){
      return false;
    }
  }
}