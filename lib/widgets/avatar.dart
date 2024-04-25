import 'dart:typed_data';
import 'package:flutter/material.dart';

Widget CircleCustomAvatar(context){
    Uint8List? image;
    return image == null ?
          CircleAvatar(
            backgroundImage:
            NetworkImage('https://irecommend.ru/sites/default/files/product-images/1355960/FCtcXQX22GyEDWtOMIw.jpg'),
            radius: 70,) : CircleAvatar(
              backgroundImage: MemoryImage(image!),radius: 70,);}