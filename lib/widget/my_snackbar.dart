import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/utils/tools.dart';

class MySnackbar {
  static void errorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.replaceAll("Exception:", ""),
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red[400],
      ),
    );
  }

  static void successSnackbarDismisable(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green,
          ),
        )
        .closed
        .then((value) {
      Tools.finish(context);
    });
  }

  static void successSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    )
        .closed
        .then((value) {
    });
  }

  static void warningSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.yellow,
      ),
    );
  }

  static void showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: MyColors.grey_40,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
