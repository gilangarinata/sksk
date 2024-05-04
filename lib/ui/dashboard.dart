import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/koinkita/koinkita.dart';
import 'package:solar_kita/ui/media/media.dart';
import 'package:solar_kita/ui/monitoring/Monitoring.dart';
import 'package:solar_kita/ui/notification/notification.dart';
import 'package:solar_kita/ui/profile/profile.dart';
import 'package:solar_kita/utils/tools.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> imagesBottomActive = ["assets/2a.png","assets/3a.png","assets/4a.png","assets/5a.png",];
  List<String> imagesBottomInActive = ["assets/2b.png","assets/3b.png","assets/4b.png","assets/5b.png",];
  List<String> currentActive = ["assets/2a.png","assets/3b.png","assets/4b.png","assets/5b.png",];

  String _title = MyStrings.monitoring;

  String? selectedProfileImage = "";

  void getSelectedProfileImage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedProfileImage = prefs.getString("AVATAR-IMAGE");
    });
  }

  @override
  void initState() {
    super.initState();
    getSelectedProfileImage();
    _tabController = TabController(length: 4, vsync: this);
    var count = 0;
    _tabController.addListener((){
      count++;
      if(count == 1) {
        var index = _tabController.index;
        var prevIndex = _tabController.previousIndex;
        print(prevIndex);
        setState(() {
          setTitle(index);
          currentActive[prevIndex] = imagesBottomInActive[prevIndex];
          currentActive[index] = imagesBottomActive[index];
        });
      }
      if(count == 2) count = 0;
    });
  }

  void setTitle(int index){
    switch(index){
      case 0 : _title = MyStrings.monitoring;
              break;
      case 1 : _title = MyStrings.koinkita;
      break;
      case 2 : _title = MyStrings.notification;
      break;
      case 3: _title = MyStrings.media;
      break;
    }
    getSelectedProfileImage();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Tools.addScreen(context, ProfileScreen());
            },
            child: CircleAvatar(
              backgroundColor: MyColors.accentDark,
              child: ClipRRect(
                borderRadius:BorderRadius.circular(50),
                child: selectedProfileImage == null ? Image.asset("assets/avatar1.png")  : Image.asset(selectedProfileImage ?? ""),
              ),
            ),
          ),
          SizedBox(width: 20,)
        ],
        title: MyText.myTextHeader2(_title, MyColors.accentDark),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  MonitoringScreen(),
                  KoinKitaScreen(),
                  NotificationScreen(
                    itemClick: (id){
                      _tabController.animateTo(1);
                    },
                  ),
                  MediaScreen(),
                ],
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0),),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.all(0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab, indicatorWeight: 1,
                  unselectedLabelColor: Colors.grey[600], labelColor: Colors.deepOrange[500],
                  tabs: [
                    Tab(child : Image.asset(currentActive[0])),
                    Tab(child: Image.asset(currentActive[1])),
                    Tab(child: Image.asset(currentActive[2])),
                    Tab(child: Image.asset(currentActive[3]))
                  ],
                  controller: _tabController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
