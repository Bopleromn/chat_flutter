import 'package:authentication/core/styles/text_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../screens/chat_screen.dart';

//

Widget CustomDropdownMenu({required context, required ChatScreenState chatScreen, required List<MenuItem> menuItems, required Widget child}){
  return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: child,
        items: [
          ...menuItems.map((item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: item.buildItem(),
            ),
          ),
        ],
        onChanged: (value) {
          onItemChanged(value as MenuItem, chatScreen);
        },
        //buttonStyleData: ButtonStyleData(decoration: BoxDecoration(color: Colors.transparent)),
        dropdownStyleData: DropdownStyleData(
          width: 170,
          maxHeight: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          scrollbarTheme: ScrollbarThemeData(thickness: MaterialStateProperty.all<double>(0.0)),
        ),
      )
  );
}

void onItemChanged(MenuItem item, ChatScreenState chatScreen){
  if(item.text == 'Очистить чат'){
    chatScreen.clearAllMessages();
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  Widget buildItem() {
    return Row(
      children: [
        Icon(icon, color: Colors.black, size: 12.sp),
        Expanded(
          child: Text(text, style: small_black().copyWith(fontSize: 10.sp)
        ),
        ),
      ],
    );
  }
}