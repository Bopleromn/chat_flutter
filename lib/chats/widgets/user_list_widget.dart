import 'package:authentication/core/styles/colors.dart';
import 'package:authentication/core/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../authentication/models/user_model.dart';
import '../screens/chats_screen.dart';

Widget users_list_widget(BuildContext context, int index){
  if(index >= ChatsScreenState.users.length){
    return Container();
  }

  UserModel user = ChatsScreenState.users[index];

  return GestureDetector(
      onTap: (){
        goToChat(user, context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: 2,
                color: Colors.grey.withOpacity(0.5)
            )
        ),
        child: Row(
          children: [
            Expanded(child: Container(),flex: 5,),
            Expanded(child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/manimage.png'),
            ),flex: 20,),
            Expanded(child: Container(),flex: 3,),
            Expanded(child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container(),flex: 10,),
                  Expanded(child: Text(user.name!, style: medium_black(),),flex: 20,),
                  Expanded(child: Container(),flex: 2,),
                  Expanded(child: Text(user.email!, style: small_black(),),flex: 15,),
                  Expanded(child: Container(),flex: 10,)
                ],
              ),
            ),flex: 60,),
            Expanded(child: Container(),flex: 3,),
          ],
        ),
      )
  );
}