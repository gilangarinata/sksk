import 'dart:ffi';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/res/my_colors.dart';

class ChartView extends StatefulWidget {

  List<GraphDayResponse> items;

  ChartView(this.items);

  @override
  _ChartViewState createState() => _ChartViewState(items);
}

class _ChartViewState extends State<ChartView> {

  bool isShowingMainData;
  List<GraphDayResponse> items;

  _ChartViewState(this.items);

  @override
  void initState() {
    super.initState();
    print("Gilangchart : ${items.length}");
    isShowingMainData = true;
  }

  List<FlSpot> getPoints(){
    List<FlSpot> points = [];
    if(items != null) {
      for (int i = 0; i < items.length; i++) {
        var hour = items[i].timeI;
        var power = items[i].power;
        points.add(FlSpot(i.toDouble(), power));
      }
    }
    print(points);
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
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
    );
  }

  List<Color> gradientColors = [
    MyColors.accentDark,
    MyColors.accentDark,
  ];
  
  String getTime(double value){
    if(items != null){
      if(value.toInt() % 4 == 0){
        return items[value.toInt()].timeI;
      }else{
        return null;
      }
    }else{
      return '';
    }
  }

  String getTimeDetail(double value){
    if(items != null){
      return items[value.toInt()].timeI;
    }else{
      return '';
    }
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
            return getTime(value);
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
        if (e.power > max.power) max = e;
      });
    return max.power.toDouble() + (max.power.toDouble() * 50.0 / 100.0) ;
    }else{
      return 0.0;
    }
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      spots: getPoints(),
      isCurved: true,
      colors: [
        MyColors.accentDark,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
      ),
    );

    return [
      lineChartBarData1
    ];
  }

}
