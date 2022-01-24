import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solar_kita/res/my_button.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_field_style.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/koinkita/koinkita.dart';
import 'package:solar_kita/ui/monitoring/Monitoring.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        centerTitle: true,

        title: MyText.myTextHeader2(MyStrings.changePass, MyColors.accentDark),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(height: 20,),
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
                labelText: MyStrings.oldPassword,
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
                labelText: MyStrings.newPassword,
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
                labelText: MyStrings.reEnterNewPassword,
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
