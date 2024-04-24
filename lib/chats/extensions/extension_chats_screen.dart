part of '../screens/chats_screen.dart';

extension on ChatsScreenState{
  Future<List<UserModel>> initAllUsers() async {
    final response = await Dio().get(
        'http://${globals.ip}/users/all'
    );

    final data = (response.data as Map<String, dynamic>)['data'] as List<
        dynamic>;

    List<UserModel> users = [];

    data.forEach((user) {
      UserModel userToAdd = UserModel.filled(
          id: user['id'], email: user['email'], name: user['name']);

      if (userToAdd.id != GetIt
          .I<UserModel>()
          .id) {
        users.add(userToAdd);
      }
    });

    return users;
  }
}

void goToChat(UserModel otherUser, context) async {
  var json = {
    'data': [
      GetIt.I<UserModel>().id,
      otherUser.id
    ]
  };

  final response = await Dio().post(
    'http://${globals.ip}/chats/', data: json,
  );

  final data = response.data as Map<String, dynamic>;

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>
        ChatScreen(roomId: data['data']['room_id'], otherUser: otherUser)),
  );
}