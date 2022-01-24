import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solar_kita/res/my_button.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_field_style.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/koinkita/koinkita.dart';
import 'package:solar_kita/ui/monitoring/Monitoring.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        centerTitle: true,

        title: MyText.myTextHeader2(MyStrings.updateProfile, MyColors.accentDark),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
              radius: 30,
              backgroundColor: MyColors.accentDark,
              child: Icon(Icons.person),
            ),
            TextFormField(
              style: MyFieldStyle.myFieldStylePrimary(),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return MyStrings.mustNotEmpty;
                }
                return null;
              },
              cursorColor: MyColors.primary,
              decoration: InputDecoration(
                icon: Container(
                    child:
                    Icon(Icons.person, color: MyColors.grey_60),
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                labelText: MyStrings.name,
                labelStyle: MyFieldStyle.myFieldLabelStylePrimary(),
                enabledBorder: MyFieldStyle.myUnderlineFieldStyle(),
                focusedBorder:
                MyFieldStyle.myUnderlineFocusFieldStyle(),
              ),
            ),
            TextFormField(
              style: MyFieldStyle.myFieldStylePrimary(),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return MyStrings.mustNotEmpty;
                }
                return null;
              },
              cursorColor: MyColors.primary,
              decoration: InputDecoration(
                icon: Container(
                    child:
                    Icon(Icons.business, color: MyColors.grey_60),
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                labelText: MyStrings.company,
                labelStyle: MyFieldStyle.myFieldLabelStylePrimary(),
                enabledBorder: MyFieldStyle.myUnderlineFieldStyle(),
                focusedBorder:
                MyFieldStyle.myUnderlineFocusFieldStyle(),
              ),
            ),
            TextFormField(
              style: MyFieldStyle.myFieldStylePrimary(),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return MyStrings.mustNotEmpty;
                }
                return null;
              },
              cursorColor: MyColors.primary,
              decoration: InputDecoration(
                icon: Container(
                    child:
                    Icon(Icons.email, color: MyColors.grey_60),
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                labelText: MyStrings.email,
                labelStyle: MyFieldStyle.myFieldLabelStylePrimary(),
                enabledBorder: MyFieldStyle.myUnderlineFieldStyle(),
                focusedBorder:
                MyFieldStyle.myUnderlineFocusFieldStyle(),
              ),
            ),
            SizedBox(height: 100,),
            MyButton.myPrimaryButton(MyStrings.save, (){

            })
          ],
        ),
      ),
    );
  }
}
