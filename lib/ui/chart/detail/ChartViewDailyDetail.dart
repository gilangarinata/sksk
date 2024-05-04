import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/res/my_colors.dart';

class ChartViewDailyDetail extends StatefulWidget {

  List<GraphDayResponse> items;

  ChartViewDailyDetail(this.items);

  @override
  _ChartViewState createState() => _ChartViewState(items);
}

class _ChartViewState extends State<ChartViewDailyDetail> {

  late bool isShowingMainData;
  List<GraphDayResponse> items;

  _ChartViewState(this.items);

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  List<FlSpot> getPoints(){
    List<FlSpot> points = [];
    if(items != null) {
      for (int i = 0; i < items.length; i++) {
        var hour = items[i].timeI;
        var power = items[i].power;
        points.add(FlSpot(i.toDouble(), power ?? 0.0));
      }
    }
    print(points);
    return points;
  }

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: const Border(
      bottom: BorderSide(color: Color(0xffb4b2bd), width: 2),
      left: BorderSide(color: Colors.transparent),
      right: BorderSide(color: Colors.transparent),
      top: BorderSide(color: Colors.transparent),
    ),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: MyColors.white,),
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                gradient: LinearGradient(
                  colors: [
                    MyColors.white,
                    MyColors.white,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      const SizedBox(
                        height: 37,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                          child: LineChart(
                            isShowingMainData ? sampleData1() : sampleData1(),
                            swapAnimationDuration: const Duration(milliseconds: 250),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
                    ),
                    onPressed: () {
                      setState(() {
                        isShowingMainData = !isShowingMainData;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? getTimeDetail(double value){
    if(items != null){
      return items[value.toInt()].timeI;
    }else{
      return '';
    }
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
          getTooltipItems: (value) {
            return value
                .map((e) => LineTooltipItem(
                "Power: ${e.y}kW  \n Time: ${getTimeDetail(e.x)}",
                TextStyle(color: MyColors.grey_60)))
                .toList();
          },
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
          show: true,
          horizontalInterval: 0.5
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          rotateAngle: 40,
          reservedSize: 22,
          getTextStyles: (value,as) => const TextStyle(
            color: MyColors.grey_60,
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
          margin: 10,
          getTitles: (value) {
            if(items != null){
              if(value.toInt() % 4 == 0){
                return items[value.toInt()].timeI ?? "";
              }else{
                return "";
              }
            }else{
              return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value,as) => const TextStyle(
              color: MyColors.grey_60, fontWeight: FontWeight.normal, fontSize: 10),
          getTitles: (value) {
            return value.toInt().toString() + " kW";
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: borderData,
      minX: 0,
      maxX: items != null ? items.length.toDouble() : 30,
      maxY: getMaxItemY(),
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  double getMaxItemY(){
    if(items != null){
      GraphDayResponse max = items.first;
      items.forEach((e) {
        if ((e.power ?? 0.0) > (max.power ?? 0.0)) max = e;
      });
    return (max.power?.toDouble() ?? 0.0) + ((max.power?.toDouble() ?? 0.0) * 50 / 100);
    }else{
      return 0.0;
    }
  }

  List<Color> gradientColors = [
    MyColors.accentDark,
    MyColors.accentDark,
  ];

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      spots: getPoints(),
      isCurved: true,
      colors: [
        MyColors.accentDark,
      ],
      belowBarData: BarAreaData(
        show: true,
        colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
      ),
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
    );

    return [
      lineChartBarData1
    ];
  }

}
