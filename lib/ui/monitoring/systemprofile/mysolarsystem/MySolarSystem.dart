import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/mysolarsystem/DetailSolarSystem.dart';
import 'package:solar_kita/utils/tools.dart';

class MySolarSystemView extends StatelessWidget {

  SystemProfileResponse response;
  List<Widget> listSystemProfile = [];

  MySolarSystemView(this.response);

  @override
  Widget build(BuildContext context) {

    for(int i = 0; i < (response.data?.solarSystems?.length ?? 0); i++){
      listSystemProfile.add(buildCardSystemProfile(i, context));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10,),
        MyText.myTextHeader2(MyStrings.mySolarSystem, MyColors.accentDark),
        SizedBox(height: 30,),
        Row(
          children: [
            Expanded(
              child: Center(child: MyText.myTextDescription(MyStrings.inverterId, MyColors.accentDark)),
            )  ,
            Expanded(
              child: Center(child: MyText.myTextDescription(MyStrings.pvSystem, MyColors.accentDark)),
            ),
            Expanded(
              child: Center(child: MyText.myTextDescription(MyStrings.location, MyColors.accentDark)),
            )
          ],
        ),
        Column(
          children: listSystemProfile,
        )
      ],
    );
  }

  Widget buildCardSystemProfile(int index, BuildContext context){
    var item = response != null ? response.data!.solarSystems![index] : null;
    return item == null ? Container() : InkWell(
      onTap: (){
        Tools.addScreen(context, DetailSolarSystem(item.invId ?? ""));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText.myTextHeader3(item.invId ?? "", MyColors.accentDark),
                  ],
                ),
              )),
              Expanded(child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText.myTextDescription(item.pvSysPower ?? "", MyColors.grey_80),
                  ],
                ),
              )),
              Expanded(child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText.myTextDescription2(item.location ?? "", MyColors.grey_80),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
