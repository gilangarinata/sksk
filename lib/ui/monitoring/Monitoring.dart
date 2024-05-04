import 'package:flutter/material.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/monitoring/services/services.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/SystemProfile.dart';

class MonitoringScreen extends StatefulWidget {
  @override
  _MonitoringScreenState createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: TabBar(
              indicatorColor: MyColors.accentDark,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4,
              tabs: [
                Tab(icon: MyText.myTextDescription(MyStrings.systemProfile, MyColors.accentDark)),
                Tab(icon: MyText.myTextDescription(MyStrings.services, MyColors.accentDark)),
              ],
              controller: _tabController,
            ),
          ),
          Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SystemProfile(),
                  ServicesScreen(),
                ],
              ))
        ],
      ),
    );
  }
}
