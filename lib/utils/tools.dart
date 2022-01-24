import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tools {
  static Navigator changeScreen(BuildContext context, Widget destination) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => destination,
      ),
    );
  }

  static Navigator addScreen(BuildContext context, Widget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => destination,
      ),
    );
  }

  static void finish(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  static void showToast(String message){
    Fluttertoast.showToast(msg: message);
  }

  static String addPadleft(String number){
    return number.padLeft(2, '0');
  }

  static int monthToNumber(String month){
    switch(month){
      case "Jan" :
        return 1;
        break;
      case "Feb" :
        return 2;
        break;
      case "Mar" :
        return 3;
        break;
      case "Apr" :
        return 4;
        break;
      case "May" :
        return 5;
        break;
      case "Jun" :
        return 6;
        break;
      case "Jul" :
        return 7;
        break;
      case "Aug" :
        return 8;
        break;
      case "Sep" :
        return 9;
        break;
      case "Oct" :
        return 10;
        break;
      case "Nov" :
        return 11;
        break;
      case "Des" :
        return 12;
        break;
      default :
        return 0;
        break;
    }
  }

  static void stackTracer(StackTrace stackTrace, String message, int code) {
    print("   ");
    print("   ");
    print("   ");
    print(
        "============================= MESSAGE : $message ======================================");
    print(
        "============================== CODE : $code =============================================");
    print(StackTrace.current);
    print("   ");
    print("   ");
    print("   ");
  }

  static List<String> dayGenerator(){
    List<String> days = [];
    for(int i=1; i<=31; i++){
      days.add(i.toString());
    }
    return days;
  }

  static Widget buildDotsVouchers(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          children: [
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}
