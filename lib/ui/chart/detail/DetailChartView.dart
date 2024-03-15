import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solar_kita/res/my_colors.dart';

class DetailChartView extends StatefulWidget {
  @override
  _DetailChartViewState createState() => _DetailChartViewState();
}

class _DetailChartViewState extends State<DetailChartView> {

  bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
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
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          width: double.infinity,
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
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
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
          reservedSize: 22,
          getTextStyles: (value,as) => const TextStyle(
            color: MyColors.grey_60,
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '06:00';
              case 4:
                return '08:00';
              case 6:
                return '10:00';
              case 8:
                return '12:00';
              case 10:
                return '14:00';
              case 12:
                return '16:00';
              case 14:
                return '18:00';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value,as) => const TextStyle(
              color: MyColors.grey_60, fontWeight: FontWeight.normal, fontSize: 10),
          getTitles: (value) {
            return value.toInt().toString() + " kWh";
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: const Border(
          bottom: BorderSide(
            color: Colors.red,
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(0, 1),
        FlSpot(1, 1.5),
        FlSpot(2, 1.4),
        FlSpot(3, 2.2),
        FlSpot(4, 3.2),
        FlSpot(5, 2.1),
        FlSpot(6, 4.0),
        FlSpot(7, 1.4),
        FlSpot(8, 2.2),
        FlSpot(9, 3.2),
        FlSpot(10, 2.1),
        FlSpot(11, 4.0),
        FlSpot(12, 3.2),
        FlSpot(13, 2.1),
        FlSpot(14, 4.0),
      ],
      isCurved: true,
      colors: [
        MyColors.accentDark,
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    return [
      lineChartBarData1
    ];
  }

}
