import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  int selectedProfile = 0;
  String selectedProfileImage = "";

  void getSelectedProfileImage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedProfileImage = prefs.getString("AVATAR-IMAGE");
    });
  }

  @override
  void initState() {
    super.initState();
    getSelectedProfile();
    getSelectedProfileImage();
  }

  void getSelectedProfile() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedProfile = prefs.getInt("AVATAR");
  }

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
            InkWell(
              onTap: (){
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: CircleAvatar(
                                    radius: 50,
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.circular(50),
                                      child: Image.asset("assets/avatar1.png"),
                                    ),
                                  ),
                                  onTap: () async{
                                    setState(() {
                                      selectedProfile = 0;
                                    });
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString("AVATAR-IMAGE", "assets/avatar1.png");
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: MyColors.accentDark,
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.circular(50),
                                      child: Image.asset("assets/avatar2.png"),
                                    ),
                                  ),
                                  onTap: () async{
                                    setState(() {
                                      selectedProfile = 1;
                                    });
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString("AVATAR-IMAGE", "assets/avatar2.png");
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: MyColors.accentDark,
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.circular(50),
                                      child: Image.asset("assets/avatar3.png"),
                                    ),
                                  ),
                                  onTap: () async{
                                    setState(() {
                                      selectedProfile = 2;
                                    });
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString("AVATAR-IMAGE", "assets/avatar3.png");
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: MyColors.accentDark,
                                    child: ClipRRect(
                                      borderRadius:BorderRadius.circular(50),
                                      child: Image.asset("assets/avatar4.png"),
                                    ),
                                  ),
                                  onTap: () async{
                                    setState(() {
                                      selectedProfile = 3;
                                    });
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString("AVATAR-IMAGE", "assets/avatar4.png");
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                        ],
                      );
                    }).then((value) {
                  getSelectedProfileImage();
                });
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: MyColors.accentDark,
                child: ClipRRect(
                  borderRadius:BorderRadius.circular(50),
                  child: selectedProfileImage == null ? Image.asset("assets/avatar1.png")  : Image.asset(selectedProfileImage),
                ),
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
