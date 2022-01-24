import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/data/dummy.dart';
import 'package:solar_kita/model/OnboardingModel.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/login/login_screen.dart';
import 'package:solar_kita/utils/tools.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<OnboardingModel> wizardData = Dummy.getWizard();
  PageController pageController = PageController(
    initialPage: 0,
  );
  int page = 0;
  bool isLast = false;
  String textNext = "Next";
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    var queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    print("DPR: " + devicePixelRatio.toString());
    return Scaffold(
      backgroundColor: MyColors.white,
      body: Column(
        children: [
          Image.asset('assets/header.png'),
          Expanded(
            child: PageView(
              onPageChanged: onPageViewChange,
              controller: pageController,
              children: buildPageViewItem(),
            ),
          ),
          Stack(
            children: [
              Container(
                height: 60,
                child: Align(
                  alignment: Alignment.center,
                  child: buildDots(context),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        if(isLast){
                          Tools.changeScreen(context, LoginScreen());
                        }else{
                          pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                        }
                      },
                        child: MyText.myTextHeader2(textNext, MyColors.accentDark))),
              )
            ],
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }

  void onPageViewChange(int _page) {
    page = _page;
    isLast = _page == wizardData.length-1;
    setState(() {
      if(isLast){
        textNext = "Skip";
      }else{
        textNext = "Next";
      }
    });
  }

  List<Widget> buildPageViewItem(){
    List<Widget> widgets = [];
    for(OnboardingModel wz in wizardData){
      Widget wg = Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: double.infinity, height: double.infinity,
        child: Wrap(
          children : <Widget>[
            Container(
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(wz.image, width: size.width / 2),
                        MyText.myTextHeader1(wz.title, MyColors.accentDark),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          child: Text(wz.brief, textAlign : TextAlign.center, style: MyText.subhead(context).copyWith(
                              color: MyColors.grey_60
                          )),
                        ),
                      ],
                    )
                  ],
                )
            )
          ],
        ),
      );
      widgets.add(wg);
    }
    return widgets;
  }

  Widget buildDots(BuildContext context){
    Widget widget;

    List<Widget> dots = [];
    for(int i=0; i<wizardData.length; i++){
      Widget w = Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 8,
        width: 8,
        child: CircleAvatar(
          backgroundColor: page == i ? MyColors.accentDark : MyColors.grey_20,
        ),
      );
      dots.add(w);
    }
    widget = Row(
      mainAxisSize: MainAxisSize.min,
      children: dots,
    );
    return widget;
  }
}
