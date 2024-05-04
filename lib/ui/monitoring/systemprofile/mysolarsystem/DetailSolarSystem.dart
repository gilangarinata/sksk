import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';
import 'package:solar_kita/network/repository/graph_repository.dart';
import 'package:solar_kita/network/repository/system_profile_repository.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/res/my_button.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/chart/BarChartViewMonthly.dart';
import 'package:solar_kita/ui/chart/BarChartViewTotal.dart';
import 'package:solar_kita/ui/chart/BarChartViewYearly.dart';
import 'package:solar_kita/ui/chart/chartView.dart';
import 'package:solar_kita/ui/chart/chart_bloc.dart';
import 'package:solar_kita/ui/chart/chart_event.dart';
import 'package:solar_kita/ui/chart/chart_state.dart';
import 'package:solar_kita/ui/chart/detail/BarChartViewMonthlyDetail.dart';
import 'package:solar_kita/ui/chart/detail/BarChartViewTotalDetail.dart';
import 'package:solar_kita/ui/chart/detail/BarChartViewYearlyDetail.dart';
import 'package:solar_kita/ui/chart/detail/ChartViewDailyDetail.dart';
import 'package:solar_kita/ui/chart/detail/DetailChartView.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/mysolarsystem/SolarSystemProfile.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/systemprofile_bloc.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/systemprofile_event.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/systemprofile_state.dart';
import 'package:solar_kita/utils/tools.dart';
import 'dart:ui' as ui;

import 'package:solar_kita/widget/my_snackbar.dart';
import 'package:solar_kita/widget/progress_loading.dart';

class DetailSolarSystem extends StatelessWidget {

  String inverterId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChartBloc>(
          create: (context) => ChartBloc(GraphRepositoryImpl()),
        ),
        BlocProvider<SystemProfileBloc>(
          create: (context) => SystemProfileBloc(SystemProfileRepositoryImpl(context)),
        )
      ],
      child: DetailSolarSystemChild(inverterId),
    );
  }

  DetailSolarSystem(this.inverterId);
}

class DetailSolarSystemChild extends StatefulWidget {

  String inverterId;

  DetailSolarSystemChild(this.inverterId);

  @override
  _DetailSolarSystemState createState() => _DetailSolarSystemState(inverterId);
}

class _DetailSolarSystemState extends State<DetailSolarSystemChild> {
  late ChartBloc chartBloc;
  late SystemProfileBloc systemProfileBloc;

  late List<bool> tabChartSelected = [false, false, false, false];
  late GlobalKey globalKey = GlobalKey();
  late bool chartLoading = true;

  String inverterId;
  _DetailSolarSystemState(this.inverterId);

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    _currentSelectedYear = DateFormat('yyyy').format(now);
    _currentSelectedMonth = DateFormat('MMM').format(now);
    _currentSelectedDay = DateFormat('d').format(now);
    chartBloc = BlocProvider.of<ChartBloc>(context);
    systemProfileBloc = BlocProvider.of<SystemProfileBloc>(context);

    // fetchMonthlyChart(formatDate(DateTime.now(), "MONTHLY"));
    // fetchYearlyChart(formatDate(DateTime.now(), "YEARLY"));
    // fetchTotalChart();
    var m = Tools.addPadleft(now.month.toString());
    var y = now.year.toString();
    systemProfileBloc.add(FetchSystemProfileDetail(inverterId,"$y-$m",y));

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        setTabSelected(0);
      });
    });
  }

  String formatDate(DateTime dateTime, String type){
    switch(type){
      case "DAILY" :
        setState(() {
          // _currentSelectedDay = dateTime.day.toString();
          // _currentSelectedMonth = dateTime.month.toString();
          // _currentSelectedYear = dateTime.year.toString();
          processDate();
        });
        return DateFormat('yyyy-MM-dd').format(dateTime);
        break;
      case "MONTHLY" :
        return DateFormat('yyyy-MM').format(dateTime);
        break;
      case "YEARLY" :
        return DateFormat('yyyy').format(dateTime);
        break;
      default :
        return "";
        break;
    }
  }
  
  void fetchDailyChart(String date){
    chartBloc.add(FetchDailyGraph(date, widget.inverterId));
  }

  void fetchMonthlyChart(String date){
    chartBloc.add(FetchMonthlyGraph(date, widget.inverterId));
  }

  void fetchYearlyChart(String date){
    chartBloc.add(FetchYearlyGraph(date, widget.inverterId));
  }

  void fetchTotalChart(){
    chartBloc.add(FetchTotalGraph(widget.inverterId));
  }

  int indexSelected = 0;

  void setTabSelected(int index) {
    indexSelected = index;
    setState(() {
      for (int i = 0; i < tabChartSelected.length; i++) {
        if (i == index) {
          tabChartSelected[i] = true;
        } else {
          tabChartSelected[i] = false;
        }
      }
    });

    // if(index == 0){
    //   fetchDailyChart(formatDate(DateTime.now(), "DAILY"));
    // }else if(indexSelected == 1){
    //   fetchMonthlyChart(formatDate(DateTime.now(), "MONTHLY"));
    // }else if(indexSelected == 2){
    //   fetchYearlyChart(formatDate(DateTime.now(), "YEARLY"));
    // }else if(indexSelected == 3){
    //   fetchTotalChart();
    // }

    processDate();
  }

  late  String _currentSelectedYear;
  late  String _currentSelectedMonth;
  late String _currentSelectedDay;
  bool _isLoading = true;
  List<GraphDayResponse> dailyGraphResponse = [];
  List<GraphMonthResponse> monthlyGraphResponse = [];
  List<GraphYearResponse> yearlyGraphResponse = [];
  List<GraphTotalResponse> totalGraphResponse= [];
  late SystemProfileResponse systemDataResponse;

  void processDate(){
    if(_currentSelectedDay != null && _currentSelectedMonth != null && _currentSelectedYear != null){
      var day = Tools.addPadleft(_currentSelectedDay);
      var month = Tools.addPadleft(Tools.monthToNumber(_currentSelectedMonth).toString());
      var year = _currentSelectedYear;
      if(tabChartSelected[0] == true){
        var date = year + "-" + month + "-" + day;
        fetchDailyChart(date);
        var monthQuery = year + "-" + month;
        systemProfileBloc.add(FetchSystemProfileDetail(inverterId,monthQuery, year));
      }else if(tabChartSelected[1] == true){
        var monthQuery = year + "-" + month;
        fetchMonthlyChart(monthQuery);
        systemProfileBloc.add(FetchSystemProfileDetail(inverterId,monthQuery, year));
      }else if(tabChartSelected[2] == true){
        fetchYearlyChart(year);
        var monthQuery = year + "-" + month;
        systemProfileBloc.add(FetchSystemProfileDetail(inverterId,monthQuery, year));
      }else if(tabChartSelected[3] == true){
        fetchTotalChart();
      }
    }
  }

  Future<void> _capturePng() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool isDemo = prefs.getBool(PrefData.IS_DEMO) ?? false;
    //
    // if(isDemo){
    //   MySnackbar.showToast("Not Available. You are using demo account.");
    //   return;
    // }
    //
    // RenderObject? boundary = globalKey.currentContext?.findRenderObject();
    // ui.Image image = await boundary?.toImage();
    // ByteData? byteData = await image.toByteData(format:       ui.ImageByteFormat.png);
    // Uint8List? capturedBytes = byteData?.buffer.asUint8List();
    //
    // try {
    //
    //   final tempDir = await getTemporaryDirectory();
    //   final file = await new File('${tempDir.path}/image.jpg').create();
    //   file.writeAsBytesSync(capturedBytes as List<int>);
    //
    //   Share.shareFiles(['${tempDir.path}/image.jpg'], text: '');
    // } catch (e) {
    //   print('Share error: $e');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: MyColors.accentDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: MyText.myTextHeader2("Inverter : " + inverterId, MyColors.accentDark),
      ),
      body : BlocListener<SystemProfileBloc, SystemProfileState?>(
        listener: (context, state) async {
          if (state is SystemProfileError) {
            setState(() {
              _isLoading = false;
              MySnackbar.errorSnackbar(context, "Error loading monitoring data");
            });
          } else if (state is SystemProfileDetailLoaded) {
            setState(() {
              _isLoading = false;
              systemDataResponse = state.items;
            });
          }
        },
        child: BlocListener<ChartBloc, ChartState?>(
          listener: (context, state) async {
            if (state is InitialState) {

            }
            else if (state is LoadingState) {
              setState(() {
                chartLoading = true;
              });
            } else if (state is ErrorState) {
              setState(() {
                chartLoading = false;
                MySnackbar.errorSnackbar(context, state.message);
              });
            }else if (state is ChartDailyLoaded) {
              setState(() {
                dailyGraphResponse = state.items;
                chartLoading = false;
              });
            }else if (state is ChartMonthlyLoaded) {
              setState(() {
                monthlyGraphResponse = state.items;
                chartLoading = false;
              });
            }else if (state is ChartYearlyLoaded) {
              setState(() {
                yearlyGraphResponse = state.items;
                chartLoading = false;
              });
            }else if (state is ChartTotalLoaded) {
              setState(() {
                totalGraphResponse = state.items;
                chartLoading = false;
              });
            }
          },
          child: _isLoading ? ProgressLoading() : RepaintBoundary(
            key: globalKey,
            child: Container(
              color: MyColors.white,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: MyColors.primary,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          MyText.myTextHeader2(
                              MyStrings.todaysProduction, MyColors.accentDark),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyText.bigText(systemDataResponse != null ? systemDataResponse.data!.todayProduction.toString() : "0", MyColors.accentDark),
                              MyText.myTextDescription(
                                  MyStrings.kwh, MyColors.accentDark)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: MyColors.primary,
                          child: Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                MyText.myTextHeader2(
                                    MyStrings.monthEnergy, MyColors.accentDark),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    MyText.bigText(systemDataResponse != null ? systemDataResponse.data!.monthlyEnergy.toString() : "-", MyColors.accentDark),
                                    MyText.myTextDescription(
                                        MyStrings.kwh, MyColors.accentDark)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: MyColors.primary,
                          child: Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                MyText.myTextHeader2(
                                    MyStrings.monthSaving, MyColors.accentDark),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    MyText.myTextDescription(
                                        MyStrings.rp, MyColors.accentDark),
                                    MyText.bigText(systemDataResponse != null ? systemDataResponse.data!.monthlySaving.toString() : "-", MyColors.accentDark),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: MyColors.accentDark, width: 2)),
                    child: Center(
                        child: MyText.myTextHeader2(
                            "CO2 Reduced = " + (systemDataResponse != null ? systemDataResponse.data!.co2Reduced.toString() : 0).toString() + "kg", MyColors.accentDark)),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: MyColors.grey_40,
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText.myTextDescription2(MyStrings.totalEnergy, MyColors.accentDark),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MyText.myTextHeader1(systemDataResponse != null ? systemDataResponse.data!.totalEnergy.toString() : "-", MyColors.accentDark),
                                        SizedBox(width: 5,),
                                        MyText.myTextDescription2(MyStrings.kwh, MyColors.accentDark)
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          Expanded(
                              child: Container(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Colors.white,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MyText.myTextDescription2(
                                            MyStrings.totalSaving, MyColors.accentDark),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            MyText.myTextDescription2(
                                                MyStrings.rp, MyColors.accentDark),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            MyText.myTextHeader1(
                                                systemDataResponse != null ? systemDataResponse.data!.totalSaving.toString() : "-", MyColors.accentDark),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  MyButton.myBorderButton(
                    MyStrings.share,
                    10,
                        () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          bool isDemo = prefs.getBool(PrefData.IS_DEMO) ?? false;

                          if(isDemo){
                            MySnackbar.showToast("Not Available. You are using demo account.");
                            return;
                          }
                      _capturePng();
                    },
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: MyColors.grey_3,
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  setTabSelected(0);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: tabChartSelected[0]
                                        ? MyColors.accentDark
                                        : MyColors.grey_3,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: MyText.myTextDescription(
                                        "Today",
                                        tabChartSelected[0]
                                            ? Colors.white
                                            : MyColors.accentDark),
                                  ),
                                ),
                              )),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  setTabSelected(1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: tabChartSelected[1]
                                        ? MyColors.accentDark
                                        : MyColors.grey_3,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: MyText.myTextDescription(
                                        "Daily",
                                        tabChartSelected[1]
                                            ? Colors.white
                                            : MyColors.accentDark),
                                  ),
                                ),
                              )),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  setTabSelected(2);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: tabChartSelected[2]
                                        ? MyColors.accentDark
                                        : MyColors.grey_3,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: MyText.myTextDescription(
                                        "Monthly",
                                        tabChartSelected[2]
                                            ? Colors.white
                                            : MyColors.accentDark),
                                  ),
                                ),
                              )),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  setTabSelected(3);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: tabChartSelected[3]
                                        ? MyColors.accentDark
                                        : MyColors.grey_3,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: MyText.myTextDescription(
                                        "Yearly",
                                        tabChartSelected[3]
                                            ? Colors.white
                                            : MyColors.accentDark),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  checkSelected(tabChartSelected),
                  chartLoading ? Container(
                      height: 300,
                      child: Center(child: ProgressLoading())) :
                  tabChartSelected[0] == true ?
                  ChartView(dailyGraphResponse) :
                  tabChartSelected[1] == true ?
                  Container(height: 300, child: BarChartMonthly(graphMonthResponse: monthlyGraphResponse,)) :
                  tabChartSelected[2] == true ?
                  Container(height: 300, child: BarChartYearly(graphYearResponse: yearlyGraphResponse,)) :
                  Container(height: 300, child: BarChartTotal(graphTotalResponse: totalGraphResponse,)),
                  // child: Center(child: ProgressLoading())) : tabChartSelected[0] == true ? ChartView(dailyGraphResponse) : BarChartSample1(index: tabChartSelected[1] ? 0 : tabChartSelected[2] ? 1 : tabChartSelected[3] ? 2 : -1, graphMonthResponse: monthlyGraphResponse,),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyButton.myBorderButton(
                        MyStrings.seeDetail,
                        10,
                            () {
                          Widget v = ChartViewDailyDetail(dailyGraphResponse);
                          if(tabChartSelected[0]){
                            v = ChartViewDailyDetail(dailyGraphResponse);
                          }else if(tabChartSelected[1]){
                            v = BarChartMonthlyDetail(graphMonthResponse: monthlyGraphResponse,);
                          }else if(tabChartSelected[2]){
                            v = BarChartYearlyDetail(graphYearResponse: yearlyGraphResponse,);
                          }else{
                            v = BarChartTotalDetail(graphTotalResponse: totalGraphResponse,);
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => v,
                            ),
                          ).then((value) {
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitDown,
                              DeviceOrientation.portraitUp,
                            ]);
                          });
                        },
                      ),
                      MyButton.myBorderButton(
                        MyStrings.share,
                        10,
                            () {
                          _capturePng();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SolarSystemProfile(systemDataResponse != null ? systemDataResponse.data?.solarSystemProfile : null)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget checkSelected(List<bool> selectId) {
    if (selectId[0]) {
      return todayDropdownView();
    } else if (selectId[1]) {
      return dailyDropdownView();
    } else if (selectId[2]) {
      return monthlyDropdownView();
    }else{
      return Container();
    }
  }

  Widget todayDropdownView() {
    return Row(
      children: [
        MyText.myTextDescription2(MyStrings.year, MyColors.grey_80),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    labelStyle: TextStyle(fontSize: 10),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 10.0),
                    hintText: 'Please select expense',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                isEmpty: _currentSelectedYear == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currentSelectedYear,
                    isDense: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _currentSelectedYear = newValue ?? "";
                        state.didChange(newValue);
                        processDate();
                      });
                    },
                    items: MyStrings.years.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 10),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          )),
        ),
        SizedBox(
          width: 10,
        ),
        MyText.myTextDescription2(MyStrings.month, MyColors.grey_80),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    labelStyle: TextStyle(fontSize: 10),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 10.0),
                    hintText: 'Please select expense',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                isEmpty: _currentSelectedMonth == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currentSelectedMonth,
                    isDense: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _currentSelectedMonth = newValue ?? "";
                        state.didChange(newValue);
                        processDate();
                      });
                    },
                    items: MyStrings.months.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 10),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          )),
        ),
        SizedBox(
          width: 10,
        ),
        MyText.myTextDescription2(MyStrings.day, MyColors.grey_80),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    labelStyle: TextStyle(fontSize: 10),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 10.0),
                    hintText: 'Please select expense',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                isEmpty: _currentSelectedDay == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currentSelectedDay,
                    isDense: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _currentSelectedDay = newValue ?? "";
                        state.didChange(newValue);
                        processDate();
                      });
                    },
                    items: Tools.dayGenerator().map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 10),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          )),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget dailyDropdownView() {
    return Row(
      children: [
        MyText.myTextDescription2(MyStrings.year, MyColors.grey_80),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    labelStyle: TextStyle(fontSize: 10),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 10.0),
                    hintText: 'Please select expense',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                isEmpty: _currentSelectedYear == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currentSelectedYear,
                    isDense: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _currentSelectedYear = newValue ?? "";
                        state.didChange(newValue);
                        processDate();
                      });
                    },
                    items: MyStrings.years.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 10),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          )),
        ),
        SizedBox(
          width: 10,
        ),
        MyText.myTextDescription2(MyStrings.month, MyColors.grey_80),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    labelStyle: TextStyle(fontSize: 10),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 10.0),
                    hintText: 'Please select expense',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                isEmpty: _currentSelectedMonth == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currentSelectedMonth,
                    isDense: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _currentSelectedMonth = newValue ?? "";
                        state.didChange(newValue);
                        processDate();
                      });
                    },
                    items: MyStrings.months.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 10),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          )),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget monthlyDropdownView() {
    return Row(
      children: [
        MyText.myTextDescription2(MyStrings.year, MyColors.grey_80),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    labelStyle: TextStyle(fontSize: 10),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 10.0),
                    hintText: 'Please select expense',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                isEmpty: _currentSelectedYear == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currentSelectedYear,
                    isDense: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _currentSelectedYear = newValue ?? "";
                        state.didChange(newValue);
                        processDate();
                      });
                    },
                    items: MyStrings.years.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 10),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          )),
        ),
      ],
    );
  }
}
