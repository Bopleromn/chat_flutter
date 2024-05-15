import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../authentication/models/user_model.dart';
import '../../core/globals.dart';

class ChatModel{
  int roomId;
  String lastMessage;
  List<UserModel> users;

  ChatModel({required this.roomId, required this.lastMessage, required this.users});

  static Future<List<ChatModel>> getAll(List<UserModel> allUsers) async{
    // try{
      var response = await Dio().get(
        'http://${ip}/chats/rooms?user_id=${GetIt.I<UserModel>().id}'
      );

      var data = (response.data as Map<String, dynamic>)['data'] as List<dynamic>;
      List<ChatModel> chatModels = [];

      data.forEach((element) { 
        chatModels.add(
          ChatModel(
              roomId: element['room_id'],
              lastMessage: element['last_message'],
              users: allUsers.where(
                      (user) => (element['user_ids'] as List<dynamic>).contains(user.id)
              ).toList()
          )
        );
      });

      return chatModels;
    //}
    // catch (_){
    //   return [];
    // }
  }
}