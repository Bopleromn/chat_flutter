import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/globals.dart' as globals;

Map<int, String> monthNumberToMonthName = {
  1: 'Января',
  2: 'Февраля',
  3: 'Марта',
  4: 'Апреля',
  5: 'Мая',
  6: 'Июня',
  7: 'Июля',
  8: 'Августа',
  9: 'Сентября',
  10: 'Октября',
  11: 'Ноября',
  12: 'Декабря'
};

class MessageModel{
  int id;
  int userId;
  String message;
  DateTime sentAt;

  MessageModel({required this.id, required this.userId, required this.message, required this.sentAt});

  Future<bool> delete() async{
    try{
      await Dio().delete(
        'http://${globals.ip}/chats/messages/${id}'
      );

      return true;
    }
    catch (e){
      return false;
    }
  }

  Future<bool> update() async{
    try{
      await Dio().put(
        'http://${globals.ip}/chats/messages/${id}?message=${message}'
      );

      return true;
    }
    catch (e){
      return false;
    }
  }

  static Future<List<MessageModel>> getAllMessages(int roomId) async{
    List<MessageModel> messages = [];

    var response = await Dio().get(
        'http://${globals.ip}/chats/rooms/$roomId'
    );

    List<dynamic> data = (response.data as Map<String, dynamic>)['data'];

    data.forEach((msg) async {
      if(msg['message'].toString().length > 0) {
        MessageModel message = MessageModel(id: msg['id'], userId: msg['user_id'], message: msg['message'], sentAt: DateTime.parse(msg['created_at']));

        addDate(messages, message);
        messages.add(message);
      }
    });

    return messages;
  }

  static void addDate(List<MessageModel> messages, MessageModel message){
    bool canAdd = true;

    messages.forEach((element) {
      if(element.sentAt.month == message.sentAt.month && element.sentAt.day == message.sentAt.day){
        canAdd = false;
        return;
      }
    });

    if(!canAdd){
      return;
    }

    var day = message.sentAt.day, month = message.sentAt.month, year = message.sentAt.year;

    var date = year == DateTime.now().year && month== DateTime.now().month && day == DateTime.now().day ?
              'Сегодня' :  (day.toString().length == 1 ? '0' + day.toString() : day.toString()) + ' ' + monthNumberToMonthName[int.parse(month.toString())]!;

    messages.add(MessageModel(id: 0, userId: 0, message: date, sentAt: message.sentAt));
  }

  static Future<bool> clearAllMessages(int roomId) async{
    try {
      await Dio().delete(
          'http://${globals.ip}/chats/rooms/$roomId'
      );

      return true;
    }
    catch (e){
      return false;
    }
  }
}