part of '../screens/chat_screen.dart';

extension on ChatScreenState{
  void _listenToStream(){
    this._channel = WebSocketChannel.connect(
      Uri.parse('ws://${globals.ip}/chats/${roomId}/${otherUser.id}'),
    );

    _channel.stream.listen((event) async {
      if(event.toString().length > 0){
        var data = event.toString();

        if(data == '__messages_cleared__'){
          messages.clear();

          setState(() {
            messages;
          });

          state = chatState.noMessages;

          return;
        }

        int userId = int.parse(data.substring(0, data.indexOf(':')));
        String message = data.substring(data.indexOf(':') + 2);

        messages.add(MessageModel(userId: userId, message: message, sentAt: DateTime.now()));

        setState(() {
          messages;
        });

        await Future.delayed(Duration(milliseconds: 100));

        _scrollDown();
      }
    });
  }

  Future<void> _initAllMessages() async{
    messages = await MessageModel.getAllMessages(roomId);

    if(messages.length == 0){
      state = chatState.noMessages;
    }
    else{
      state = chatState.loaded;
    }

    setState(() {
      messages;
    });

    await Future.delayed(Duration(milliseconds: 100));

    _scrollDown();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _channel.sink.add(_controller.text);
      });
    }
  }

  Future<void> _clearAllMessages() async{
    if(!await MessageModel.clearAllMessages(roomId)){
      return;
    }

    state = chatState.noMessages;

    messages.clear();

    setState(() {
      messages;
    });
  }
}