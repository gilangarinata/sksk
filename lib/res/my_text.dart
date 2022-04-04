import 'package:flutter/material.dart';

class MyText {
  static RichText myTextHeader1(String title, Color color) {
    return RichText(
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: TextStyle(
            color: color, fontSize: 24.0, fontWeight: FontWeight.bold),
        text: title,
      ),
    );
  }

  static RichText myTextHeader3(String title, Color color) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      text: TextSpan(
        style: TextStyle(
            color: color, fontSize: 16.0),
        text: title,
      ),
    );
  }

  static TextStyle title(BuildContext context){
    return Theme.of(context).textTheme.subtitle1;
  }

  static TextStyle subhead(BuildContext context){
    return Theme.of(context).textTheme.bodyText2;
  }

  static RichText myTextHeader2(String title, Color color) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: TextStyle(
            color: color, fontSize: 19.0, fontWeight: FontWeight.normal),
        text: title,
      ),
    );
  }

  static RichText bigText(String title, Color color) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: TextStyle(
            color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
        text: title,
      ),
    );
  }

  static RichText myTextDescription(String title, Color color) {
    return RichText(
      maxLines: 5,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: TextStyle(color: color, fontSize: 16.0),
        text: title,
      ),
    );
  }

  static RichText myTextDescription2(String title, Color color) {
    return RichText(
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: TextStyle(color: color, fontSize: 12.0),
        text: title,
      ),
    );
  }
}
