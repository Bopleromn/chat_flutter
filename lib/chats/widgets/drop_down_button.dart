import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

Widget drop_down_button(context, ChatScreenState chatScreen){
  return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(
          Icons.list,
          size: 35,
        ),
        items: [
          ...MenuItems.items.map(
                (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value! as MenuItem, chatScreen);
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          offset: const Offset(0, 8),
        ),
      )
  );
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> items = [clear];

  static const clear = MenuItem(text: 'Очистить чат', icon: Icons.restore_from_trash);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.black, size: 22),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item, ChatScreenState chatScreen) {
    switch (item) {
      case MenuItems.clear:
        chatScreen.clearAllMessages();
        break;
    }
  }
}