import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';

class SolarSystemProfile extends StatelessWidget {
  Size size;

  List<SolarSystemProfle> solarSystemProfle;


  SolarSystemProfile(this.solarSystemProfle);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.myTextHeader2(
              MyStrings.solarSystemProfile, MyColors.accentDark),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText.myTextDescription(
                  MyStrings.pvSystemPower, MyColors.grey_60),
              Spacer(),
              Container(
                  alignment: Alignment.centerLeft,
                  width: size.width / 2,
                  child: MyText.myTextDescription(
                      ": " + (solarSystemProfle != null ? solarSystemProfle[0].pvSysPower : "-"), MyColors.grey_60)),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText.myTextDescription(
                  MyStrings.commisioning, MyColors.grey_60),
              Spacer(),
              Container(
                  alignment: Alignment.centerLeft,
                  width: size.width / 2,
                  child: MyText.myTextDescription(
                      ": " + (solarSystemProfle != null ? solarSystemProfle[0].commisioning : "-"), MyColors.grey_60)),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText.myTextDescription(MyStrings.location, MyColors.grey_60),
              Spacer(),
              Container(
                  alignment: Alignment.centerLeft,
                  width: size.width / 2,
                  child: RichText(
                    maxLines: 5,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: TextStyle(color: MyColors.grey_60, fontSize: 16.0),
                      text: ": "+ (solarSystemProfle != null ? solarSystemProfle[0].location : "-"),
                    ),
                  ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText.myTextDescription(MyStrings.modules, MyColors.grey_60),
              Spacer(),
              Container(
                  alignment: Alignment.centerLeft,
                  width: size.width / 2,
                  child: MyText.myTextDescription(
                      ": "+ (solarSystemProfle != null ? solarSystemProfle[0].modules.toString() : "-"), MyColors.grey_60)),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText.myTextDescription(MyStrings.inverter, MyColors.grey_60),
              Spacer(),
              Container(
                  alignment: Alignment.centerLeft,
                  width: size.width / 2,
                  child: MyText.myTextDescription(
                      ": " + (solarSystemProfle != null ? solarSystemProfle[0].inverter : "-"), MyColors.grey_60)),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText.myTextDescription(MyStrings.operator, MyColors.grey_60),
              Spacer(),
              Spacer(),
              Container(
                  alignment: Alignment.centerLeft,
                  width: size.width / 2,
                  child: MyText.myTextDescription(
                      ": "+ (solarSystemProfle != null ? solarSystemProfle[0].solarSystemProfleOperator : "-"), MyColors.grey_60)),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText.myTextDescription(
                  MyStrings.communication, MyColors.grey_60),
              Spacer(),
              Container(
                  alignment: Alignment.centerLeft,
                  width: size.width / 2,
                  child: MyText.myTextDescription(": "+ (solarSystemProfle != null ? solarSystemProfle[0].communication : "-"), MyColors.grey_60)),
            ],
          ),
          SizedBox(height: 40,),
        ],
      ),
    );
  }
}
