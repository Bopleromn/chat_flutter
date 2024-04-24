import 'package:dio/dio.dart';

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

    List<dynamic> data = (response.data as Map<String, dynamic>)['data'];

    data.forEach((msg) {
      if(msg['message'].toString().length > 0) {
        messages.add (
            MessageModel(userId: msg['user_id'], message: msg['message'], sentAt: DateTime.now())
        );
      }
    });

    return messages;
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