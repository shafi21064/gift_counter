
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  BuildContext context;

  Utils(this.context);

  double get width =>
      MediaQuery
          .of(context)
          .size
          .width;

  double get height =>
      MediaQuery
          .of(context)
          .size
          .height;

  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static flashBarMessage({String? message, required BuildContext context, Icon? icon, FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM }){
    Flushbar(
      message: message,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      icon: icon,
      flushbarPosition: flushbarPosition,

    ).show(context);
  }


}