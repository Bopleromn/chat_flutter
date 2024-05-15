import 'package:authentication/chats/screens/chats_screen.dart';
import 'package:authentication/core/styles/text_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

class CustomDropdownMenu extends StatelessWidget{
  CustomDropdownMenu(
  {
    required this.menuItems,
    required this.child,
    required this.callback
  });

  List<MenuItem> menuItems;
  Widget child;
  Function(MenuItem item) callback;

  @override
  Widget build(BuildContext context) {
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
            callback(value as MenuItem);
          },
          //buttonStyleData: ButtonStyleData(decoration: BoxDecoration(color: Colors.transparent)),
          dropdownStyleData: DropdownStyleData(
            width: MediaQuery.of(context).size.width * 0.35,
            //maxHeight: (50 * menuItems.length).toDouble(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            scrollbarTheme: ScrollbarThemeData(thickness: MaterialStateProperty.all<double>(0.0)),
          ),
        )
    );
  }

}

class MenuItem {
  MenuItem({
    required this.text,
    required this.icon,
  });

  String text;
  IconData icon;

  Widget buildItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.black, size: 11.sp),
        SizedBox(width: 2.sp,),
        Expanded(
          child: Text(text, style: small_black().copyWith(fontSize: 9.sp), softWrap: false,),
        ),
      ],
    );
  }
}