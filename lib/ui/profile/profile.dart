import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/koinkita/koinkita.dart';
import 'package:solar_kita/ui/login/login_screen.dart';
import 'package:solar_kita/ui/monitoring/Monitoring.dart';
import 'package:solar_kita/ui/profile/changepassword/changepassword.dart';
import 'package:solar_kita/ui/profile/contactus.dart';
import 'package:solar_kita/ui/profile/faq/faq.dart';
import 'package:solar_kita/ui/profile/privacypolicy.dart';
import 'package:solar_kita/ui/profile/termconditions.dart';
import 'package:solar_kita/ui/profile/updateprofile/updateprofile.dart';
import 'package:solar_kita/utils/tools.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/header_profile.png",width: double.infinity,),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios,color: MyColors.accentDark,),
                    ),
                    Spacer(),
                    MyText.myTextHeader2(MyStrings.myAccount, MyColors.accentDark),
                    Spacer(),
                    SizedBox(width: 50,)
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.only(top: 50 ),
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person),
                      radius: 40,
                      backgroundColor: MyColors.accentDark,
                    ),
                    SizedBox(height: 10,),
                    MyText.myTextHeader2("Username", MyColors.accentDark)
                  ],
                )
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 300),
                child: ListView(
                  children: [
                    Divider(),
                    InkWell(
                      onTap: (){
                        Tools.addScreen(context, UpdateProfileScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: MyText.myTextHeader2(MyStrings.updateProfile, MyColors.grey_80),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: (){
                        Tools.addScreen(context, ChangePasswordScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: MyText.myTextHeader2(MyStrings.changePass, MyColors.grey_80),
                      ),
                    ),
                    Divider(thickness: 5,color: MyColors.grey_5,),
                    InkWell(
                      onTap: (){
                        Tools.addScreen(context, TermAndConditionScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: MyText.myTextHeader2(MyStrings.termsCondition, MyColors.grey_80),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: (){
                        Tools.addScreen(context, PrivacyPolicyScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: MyText.myTextHeader2(MyStrings.privacyPolicy, MyColors.grey_80),
                      ),
                    ),
                    Divider(thickness: 5,color: MyColors.grey_5,),
                    InkWell(
                      onTap: (){
                        Tools.addScreen(context, FaqScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: MyText.myTextHeader2(MyStrings.faq, MyColors.grey_80),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: (){
                        Tools.addScreen(context, ContactUsScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: MyText.myTextHeader2(MyStrings.contactUs, MyColors.grey_80),
                      ),
                    ),
                    Divider(thickness: 5,color: MyColors.grey_5,),
                    InkWell(
                      onTap: (){
                        Tools.changeScreen(context, LoginScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: MyText.myTextHeader2(MyStrings.logout, Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
