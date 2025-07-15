import 'package:flutter/material.dart';

class CommonUtilsSiva{

  static const TYPE_ERROR = 1;
  static const TYPE_SUCCESS = 2;
  static const TYPE_Info = 3;

  static showSnack(BuildContext context, String message, int type){

    Color c = Color(0xFF00ADEE);

    switch(type){
      case TYPE_ERROR: c = Colors.red; break;
      case TYPE_SUCCESS: c = Colors.green; break;
      case TYPE_Info: c = Color(0xFF00ADEE); break;
    }

    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.all(8),
        height: 50,
        decoration: BoxDecoration(
          color: c,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child:  Center(
          child: Text(message, style: TextStyle(fontFamily: "Montserrat", fontSize: 14)),
        ),
      ),

    ));
  }

}