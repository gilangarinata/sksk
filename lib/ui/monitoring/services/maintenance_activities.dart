import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solar_kita/network/model/response/maintenance_list_response.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';

class MaintenanceActivities extends StatelessWidget {

  MaintenanceListResponse _maintenanceListResponse;


  MaintenanceActivities(this._maintenanceListResponse);


  Widget getList(Datum data, int number){
    var formattedDate = DateFormat("dd-MM-yyyy HH:mm").format(data.createdAt);
    if(data.date != null && data.time != null){
      var date = DateFormat("dd-MM-yyyy").format(data.date);
      var time = data.time;
      formattedDate = "$date $time";
    }
    var status = "";
    if(data.status == 1) status = "Marked"; else status = "Unmarked";
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: MyText.myTextDescription(number.toString(), MyColors.grey_60)),
          Expanded(child: MyText.myTextDescription(formattedDate, MyColors.grey_60)),
          Expanded(child: MyText.myTextDescription(status, MyColors.accentDark))
        ],
      ),
    );
  }

  List<Widget> getDatas(){
    List<Widget> list = [];
    if(_maintenanceListResponse != null) {
      for (int i = 0; i < _maintenanceListResponse.data.length; i++) {
        list.add(getList(_maintenanceListResponse.data[i], i + 1));
      }
    }
    return list;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyText.myTextHeader2("Maintenance Activities", MyColors.accentDark),
          SizedBox(height: 20,),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: MyColors.accentDark,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: MyText.myTextDescription("No", MyColors.white)),
                        Expanded(child: MyText.myTextDescription("Date", MyColors.white)),
                        Expanded(child: MyText.myTextDescription("Status", MyColors.white))
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: getDatas(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
