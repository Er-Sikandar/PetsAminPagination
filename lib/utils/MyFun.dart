import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyFun {
  void CustToastMassage(String s) {
    Fluttertoast.showToast(
        msg: '$s',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}

