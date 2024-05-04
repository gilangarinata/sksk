import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/ui/dashboard.dart';
import 'package:solar_kita/ui/login/login_screen.dart';
import 'package:solar_kita/ui/onboarding.dart';
import 'package:solar_kita/utils/tools.dart';
import 'package:solar_kita/widget/progress_loading.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _getPrefData() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.containsKey(PrefData.TOKEN);
      bool isDemo = prefs.getBool(PrefData.IS_DEMO) ?? false;
      if (isLoggedIn && !isDemo) {
        Tools.changeScreen(context, DashboardScreen());
      } else {
        try {
          var isSkipIntro = prefs.getBool("skipIntro") ?? false;
          if(isSkipIntro){
            Tools.changeScreen(context, LoginScreen());
          }else{
            Tools.changeScreen(context, OnBoardingScreen());
          }
        }catch (e){
          Tools.changeScreen(context, OnBoardingScreen());
        }
      }
    }

    Timer(Duration(seconds: 2), (){
      _getPrefData();
    });

    return Scaffold(
      backgroundColor: MyColors.primary,
      body: Center(
        child: Container(
          color: MyColors.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.redAccent,
                width: 180,
                  height: 180,
                  child: Image.asset('assets/logo.png')),
              SizedBox(height: 50,),
              ProgressLoading(stroke: 2, size: 15,)
            ],
          ),
        ),
      ),
    );
  }
}
