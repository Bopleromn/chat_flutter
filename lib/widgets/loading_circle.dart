import 'package:flutter/material.dart';

void showLoadingCircle(context){
  showDialog(
    barrierDismissible: false,
    builder: (context){
      return Center(child: CircularProgressIndicator());
    },
    context: context,
  );
}