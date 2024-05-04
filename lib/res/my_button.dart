import 'package:flutter/material.dart';
import 'package:solar_kita/res/my_colors.dart';

class MyButton {
  static ElevatedButton myPrimaryButton(String title, VoidCallback onPressed) {
    // return ElevatedButton(
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(20.0),
    //       side: BorderSide(color: MyColors.accentDark)),
    //   onPressed: onPressed,
    //   padding: EdgeInsets.symmetric(vertical: 10),
    //   color: MyColors.accentDark,
    //   textColor: Colors.white,
    //   child: Text(title, style: TextStyle(fontSize: 14)),
    // );
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.accentDark
        ),
        child: Text(title, style: TextStyle(fontSize: 14, color: Colors.white)));
  }

  static ElevatedButton myNegativeButton(String title, VoidCallback onPressed) {
    // return RaisedButton(
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(20.0),
    //       side: BorderSide(color: MyColors.grey_60)),
    //   onPressed: onPressed,
    //   padding: EdgeInsets.symmetric(vertical: 10),
    //   color: Colors.white,
    //   textColor: MyColors.grey_60,
    //   child: Text(title.toUpperCase(), style: TextStyle(fontSize: 14)),
    // );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.accentDark
      ),
      onPressed: onPressed,
      child: Text(title.toUpperCase(), style: TextStyle(fontSize: 14)),
    );
  }

  static ElevatedButton myBorderButton(String title, double cornerRadius, VoidCallback onPressed) {
    // return RaisedButton(
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(cornerRadius),
    //       side: BorderSide(color: MyColors.accentDark)),
    //   onPressed: onPressed,
    //   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    //   color: MyColors.white,
    //   textColor: MyColors.accentDark,
    //   child: Text(title, style: TextStyle(fontSize: 14)),
    // );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.accentDark
      ),
      onPressed: onPressed,
      child: Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
    );
  }

  static ElevatedButton myBorderTransparentButton(String title, double cornerRadius, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.accentDark
      ),
      onPressed: onPressed,
      child: Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
    );
    // return RaisedButton(
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(cornerRadius),
    //       side: BorderSide(color: MyColors.accentDark)),
    //   onPressed: onPressed,
    //   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
    //   textColor: MyColors.accentDark,
    //   color: MyColors.white,
    //   child: Text(title, style: TextStyle(fontSize: 14)),
    // );
  }
}
