part of '../screens/chat_screen.dart';

extension on ChatScreenState{
  void _listenToStream() async{
    this._channel = WebSocketChannel.connect(
      Uri.parse('ws://${globals.ip}/chats/${widget.roomId}/${widget.otherUser.id}'),
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
        else if(data.contains('__message_deleted__')){
          int id = int.parse(data.substring(('__message_deleted__').length));

          MessageModel messageToDelete = messages.where((element) => element.id == id).first;

          messages.removeWhere((element) => element.id == messageToDelete.id);
          if(messages.where((element) => element.sentAt.day == messageToDelete.sentAt.day &&
                            element.sentAt.month == messageToDelete.sentAt.month &&
                            element.sentAt.year == messageToDelete.sentAt.year).toList().length == 1){
            messages.removeWhere((element) =>  element.sentAt.day == messageToDelete.sentAt.day &&
                                                element.sentAt.month == messageToDelete.sentAt.month &&
                                                element.sentAt.year == messageToDelete.sentAt.year);
          }

          setState(() {
            messages;
          });

          _checkState();

          return;
        }
        else if(data.contains('__message_updated__')){
          String response = data.substring(('__message_updated__').length);
          int id = int.parse(response.substring(0, response.indexOf('_')));
          String message = response.substring(response.indexOf('_') + 1);

          messages.where((element) => element.id == id).first.message = message;

          setState(() {
            messages;
          });

          return;
        }
        else if(data.contains('__user_status_updated_${widget.otherUser.id}__')){
          await widget.otherUser.getLastSeen();

          setState(() {
            widget.otherUser.lastSeen;
          });

          print(widget.otherUser.lastSeen);

          return;
        }
        else if(data.startsWith('__user_status_updated_')){
          return;
        }

        Map<String, dynamic> message = json.decode(data);
        MessageModel messageModel = MessageModel(id: message['id'], userId: message['user_id'], message: message['message'], sentAt: DateTime.parse(message['created_at']));

        MessageModel.addDate(messages, messageModel);
        messages.add(messageModel);

        setState(() {
          messages;
        });

        await Future.delayed(Duration(milliseconds: 100));

        _scrollDown();
      }
    });
  }

  Future<void> _initAllMessages() async{
    messages = await MessageModel.getAllMessages(widget.roomId);

    _checkState();

    setState(() {
      messages;
    });

    await Future.delayed(Duration(milliseconds: 100));

    _scrollDown();
  }

  void _sendMessage() {
    if(state != chatState.loaded){
      state = chatState.loaded;
    }
    
    if (_controller.text.isNotEmpty) {
      if(isEditing){
        editingMessage!.message = _controller.text;
        editingMessage!.update();
      }
      else{
        _channel.sink.add(_controller.text);
      }
    }
    else if(isEditing){
      editingMessage!.delete();
    }

    setState(() {
      isEditing = false;
    });
  }

  void _checkState(){
    var messagesWithoutDates = messages.where((element) => element.id != 0).toList();

    if(messagesWithoutDates.length == 0){
      state = chatState.noMessages;
    }
    else{
      state = chatState.loaded;
    }
  }

  Future<void> _clearAllMessages() async{
    if(!await MessageModel.clearAllMessages(widget.roomId)){
      return;
    }

    state = chatState.noMessages;

    messages.clear();

    setState(() {
      messages;
    });
  }
}