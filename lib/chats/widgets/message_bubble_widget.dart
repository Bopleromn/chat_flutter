import 'package:authentication/core/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../authentication/models/user_model.dart';
import '../../core/styles/text_styles.dart';
import '../../core/themes.dart';
import '../models/message_model.dart';

Widget message_bubble_widget(MessageModel message, context){
  final size = MediaQuery.sizeOf(context);

  final alignment = (message.userId == GetIt.I<UserModel>().id)
      ? Alignment.centerLeft : Alignment.centerRight;

  final color = (message.userId == GetIt.I<UserModel>().id)
      ? Colors.grey : currentTheme.primaryColor;

  return GestureDetector(
    onTap: (){},
    child: Align(
      alignment: alignment,
      child: Container(
        //constraints: BoxConstraints(maxWidth: size.width * 0.66),
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
                message.message,
                style: small_white()
            ),
            SizedBox(width: 10,),
            Column(
              children: [
                SizedBox(height: 5,),
                Text(
                  message.sentAt.hour.toString() + ':' + (message.sentAt.minute.toString().length == 1 ? '0' + message.sentAt.minute.toString() : message.sentAt.minute.toString()),
                  style: TextStyle(color: light_grey(), fontSize: 10),
                  textAlign: TextAlign.end,
                ),
              ],
            )
          ],
        )
      ),
    ),
  );
}