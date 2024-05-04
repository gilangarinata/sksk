import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/ui/chart/BarChartViewMonthly.dart';

class BarChartMonthlyDetail extends StatefulWidget {
  List<GraphMonthResponse> graphMonthResponse;
  BarChartMonthlyDetail({required this.graphMonthResponse});

  @override
  State<StatefulWidget> createState() => BarChartMonthlyDetailState(graphMonthResponse);
}

class BarChartMonthlyDetailState extends State<BarChartMonthlyDetail> {
  final Color leftBarColor = MyColors.accentDark;
  final double width = 20;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  List<GraphMonthResponse> graphMonthResponse = [];


  BarChartMonthlyDetailState(this.graphMonthResponse);

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
  void initState() {
    super.initState();
    rawBarGroups = getBarChart();
    showingBarGroups = rawBarGroups;
  }

  List<BarChartGroupData> getBarChart(){
    List<BarChartGroupData> points = [];
    if(graphMonthResponse != null) {
      for (int i = 0; i < graphMonthResponse.length; i++) {
        var power = graphMonthResponse[i].dayYield;
        points.add(makeGroupData(i, power is int ? power.toDouble() : double.parse(power),0.0));
      }
    }
    return points;
  }


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
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              color: MyColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      makeTransactionsIcon(),
                      const SizedBox(
                        width: 38,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        BarChartData(
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.white,
                              getTooltipItem: (value, value2, val3, as) {
                                return BarTooltipItem(
                                    "Energy: ${val3.y}kWh  \n Date: ${value.x + 1}",
                                    TextStyle(color: MyColors.grey_60));
                              },
                            ),
                          ),
                          maxY: getMaxItemY(),
                          gridData: FlGridData(
                            show: true,
                            horizontalInterval: 2.5
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value,as) => const TextStyle(
                                  color: MyColors.grey_80, fontWeight: FontWeight.normal, fontSize: 10),
                              margin: 20,
                              getTitles: (double value) {
                                if ((value % 2) == 0) {
                                  return '';
                                } else {
                                  var dateI = graphMonthResponse[value.toInt()].dateI;
                                  return dateI ?? "";
                                }
                              },
                            ),
                            leftTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value,as) => const TextStyle(
                                  color: MyColors.grey_60, fontWeight: FontWeight.normal, fontSize: 10),
                              margin: 20,
                              interval: 8,
                              reservedSize: 45,
                              getTitles: (value) {
                                return value.toInt().toString() + " kWh";
                              },
                            ),
                          ),
                          borderData: borderData,
                          barGroups: showingBarGroups,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double getMaxItemY(){
    if(graphMonthResponse != null){
      GraphMonthResponse max = graphMonthResponse.first;
      graphMonthResponse.forEach((e) {
        double dayYield = e.dayYield is int ? e.dayYield.toDouble() : double.parse(e.dayYield);
        double dayYieldMax = max.dayYield is int ? max.dayYield.toDouble() : double.parse(max.dayYield);
        if (dayYield > dayYieldMax) max = e;
      });
      var value = max.dayYield is int ? max.dayYield.toDouble() : double.parse(max.dayYield);
      return value + (value * 50 /100);
    }else{
      return 0.0;
    }
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        borderRadius: BorderRadius.zero,
        colors: [leftBarColor],
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}