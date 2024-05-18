import 'package:chat/chats/screens/chat_screen.dart';
import 'package:chat/chats/widgets/custom_drop_down_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';

import '../../authentication/models/user_model.dart';
import '../../core/styles/colors.dart';
import '../../core/styles/text_styles.dart';
import '../../core/themes.dart';
import '../models/message_model.dart';

class MessageBubbleWidget extends StatelessWidget{
  MessageBubbleWidget(this.context, {required this.message, required this.onMessageEdited, required this.onMessageDeleted});

  BuildContext context;
  MessageModel message;
  Function(MessageModel) onMessageEdited;
  Function(MessageModel) onMessageDeleted;

  @override
  Widget build(BuildContext context) {
    if (message.userId == 0) {
      return DateBubble();
    }

   if(message.userId != GetIt.I.get<UserModel>().id) {
     return CustomDropdownMenu(
       menuItems: [
         MenuItem(text: 'Редактировать', icon: CupertinoIcons.pen),
         MenuItem(text: 'Удалить', icon: CupertinoIcons.trash)
       ],
       callback: (MenuItem item) {
         if (item.text == 'Удалить') {
          onMessageDeleted(message);
         }
         else if (item.text == 'Редактировать') {
           onMessageEdited(message);
         }
       },
       child: MessageBubble(),
     );
   }
   else{
     return MessageBubble();
   }
  }

  Widget DateBubble() {
    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.25),
      height: MediaQuery.sizeOf(context).height * 0.03,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: light_grey().withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(message.message, style: small_black(),),
    );
  }

  Widget MessageBubble(){
    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.66),
      padding: EdgeInsets.all(7.0),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: message.userId == GetIt.I.get<UserModel>().id ? currentTheme.secondaryHeaderColor :
                                                               currentTheme.primaryColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: Text(message.message, style: small_white().copyWith(color: Colors.white),)
          ),
          SizedBox(width: 2.w,),
          Text(
              message.sentAt.hour.toString() + ':' + (message.sentAt.minute.toString().length == 1
                  ? '0${message.sentAt.minute}'
                  : message.sentAt.minute.toString()),
              style: TextStyle(fontSize: 10, color: light_grey()),
              textAlign: TextAlign.right
          ),
        ],
      ),
    );
  }
}