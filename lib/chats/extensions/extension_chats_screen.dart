part of '../screens/chats_screen.dart';

extension on ChatsScreenState{
  void _goToChat(UserModel otherUser) async {
    var json = {
      'data': [
        GetIt.I<UserModel>().id,
        otherUser.id
      ]
    };

    final response = await Dio().post(
      'http://${globals.ip}/chats/rooms', data: json,
    );

    final data = response.data as Map<String, dynamic>;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          ChatScreen(roomId: data['data']['room_id'],
            otherUser: otherUser,
            callBack: initLists,)),
    );
  }

  void _search(String userName){
    if(userName.length == 0 || userName == '@'){
      setState(() => _isChat = true);
      return;
    }

    ChatsScreenState.selectedUsers = ChatsScreenState.users.where((user) => user.name.startsWith(userName)).toList();

    setState(() {
      _isChat = false;
      ChatsScreenState.selectedUsers;
    });
  }
}