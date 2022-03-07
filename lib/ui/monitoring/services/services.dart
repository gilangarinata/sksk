import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:solar_kita/network/model/response/help_center_list_response.dart';
import 'package:solar_kita/network/model/response/maintenance_list_response.dart';
import 'package:solar_kita/network/repository/service_repository.dart';
import 'package:solar_kita/res/my_button.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/monitoring/services/activities.dart';
import 'package:solar_kita/ui/monitoring/services/service_bloc.dart';
import 'package:solar_kita/ui/monitoring/services/service_event.dart';
import 'package:solar_kita/ui/monitoring/services/service_state.dart';
import 'package:solar_kita/widget/my_snackbar.dart';
import 'package:solar_kita/widget/progress_loading.dart';

import 'maintenance_activities.dart';


class ServicesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ServiceBloc>(
          create: (context) => ServiceBloc(ServiceRepositoryImpl()),
        ),
      ],
      child: ServicesScreenChild(),
    );
  }
}


class ServicesScreenChild extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreenChild> {

  final List<ServiceType> services = [ServiceType("Help", "help_center"),ServiceType("Maintenance Request", "maintenance_request")];
  final List<HelpType> helpType = [
    HelpType("Akun", 1),
    HelpType("Produk", 2),
    HelpType("Support", 3),
    HelpType("Lain-lain", 4),
  ];

  TextEditingController messageController;

  bool postingLoading = false;
  ServiceBloc bloc;
  ServiceType selectedService;
  HelpType selectedHelpType;
  String currentMessage = "";
  String currentDate = "Select Date";
  String currentTime = "Select Time";
  var serviceController = TextEditingController();

  HelpCenterListResponse _helpCenterListResponse;
  MaintenanceListResponse _maintenanceListResponse;


  void loadActivities(){
    bloc.add(FetchHelpCenterList());
    bloc.add(FetchMaintenanceList());
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ServiceBloc>(context);
    selectedService = services[0];
    serviceController.text = selectedService.name;
    selectedHelpType = helpType[0];
    messageController = TextEditingController();
    loadActivities();
  }

  _showServiceDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Select Services"),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: services
                      .map((e) => RadioListTile(
                    title: Text(e.name),
                    value: e,
                    groupValue: selectedService,
                    selected: selectedService == e,
                    onChanged: (value) {
                      if (value != selectedService.name) {
                        setState(() {
                          selectedService = value;
                        });
                        Navigator.of(context).pop();
                      }
                    },
                  ))
                      .toList(),
                ),
              ),
            ));
      });

  _showHelpTypeDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Select Help Type"),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: helpType
                      .map((e) => RadioListTile(
                    title: Text(e.name),
                    value: e,
                    groupValue: selectedHelpType,
                    selected: selectedHelpType == e,
                    onChanged: (value) {
                      if (value != selectedHelpType.name) {
                        setState(() {
                          selectedHelpType = value;
                        });
                        Navigator.of(context).pop();
                      }
                    },
                  ))
                      .toList(),
                ),
              ),
            ));
      });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServiceBloc,ServiceState>(
      listener: (context, state) async {
        if (state is LoadingState) {
          setState(() {
            postingLoading = true;
          });
        }else if (state is ServiceError) {
          setState(() {
            postingLoading = false;
            MySnackbar.errorSnackbar(context, state.message);
          });
        } else if (state is ServiceLoaded) {
          setState(() {
            postingLoading = false;
            MySnackbar.successSnackbar(context, "Sukses");
            setState(() {
              currentDate = "Select Date";
              currentTime = "Select Time";
            });
            messageController.clear();
            loadActivities();
          });
        }else if(state is HelpCenterListLoaded){
          setState(() {
            postingLoading = false;
            _helpCenterListResponse = state.items;
          });
        }else if(state is MaintenanceListLoaded){
          setState(() {
            postingLoading = false;
            _maintenanceListResponse = state.items;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 10),
        color: MyColors.white,
        child: ListView(
          children: [
            SizedBox(height: 20,),
            MyText.myTextHeader3("Services", MyColors.grey_60),
            Container(
              child: InkWell(
                onTap: (){
                  _showServiceDialog(context);
                },
                child: Card(
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15),),
                  elevation: 1,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 20,),
                      Expanded(
                        child: MyText.myTextDescription(selectedService.name, MyColors.grey_60),
                      ),
                      IconButton(icon: Icon(Icons.keyboard_arrow_down_sharp, color: Color(0xff00897B), size: 25), onPressed: () {
                        _showServiceDialog(context);
                      }),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Visibility(
              visible: selectedService.id == services[0].id,
              child: Container(
                child: InkWell(
                  onTap: (){
                    _showHelpTypeDialog(context);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15),),
                    elevation: 1,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 20,),
                        Expanded(
                          child: MyText.myTextDescription(selectedHelpType.name, MyColors.grey_60),
                        ),
                        IconButton(icon: Icon(Icons.keyboard_arrow_down_sharp, color: Color(0xff00897B), size: 25), onPressed: () {
                          _showHelpTypeDialog(context);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Visibility(
              visible: selectedService.id == services[1].id,
              child: Container(
                child: InkWell(
                  onTap: (){
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime(2030, 6, 7), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');
                          setState(() {
                            currentDate = DateFormat('yyyy-MM-dd').format(date);
                            print('change $currentDate');
                          });
                        },
                        currentTime: DateTime.now(), locale: LocaleType.id);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15),),
                    elevation: 1,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 20,),
                        Expanded(
                          child: MyText.myTextDescription(currentDate, MyColors.grey_60),
                        ),
                        IconButton(icon: Icon(Icons.calendar_today, color: Color(0xff00897B), size: 25), onPressed: () {
                          // _showHelpTypeDialog(context);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Visibility(
              visible: selectedService.id == services[1].id,
              child: Container(
                child: InkWell(
                  onTap: (){
                    DatePicker.showTimePicker(context, onChanged: (date) {

                        }, onConfirm: (date) {
                      setState(() {
                        currentTime = DateFormat('kk:mm:ss').format(date);
                        print('change $currentTime');
                      });
                        }, currentTime: DateTime.now(), locale: LocaleType.id);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15),),
                    elevation: 1,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 20,),
                        Expanded(
                          child: MyText.myTextDescription(currentTime, MyColors.grey_60),
                        ),
                        IconButton(icon: Icon(Icons.access_time_sharp, color: Color(0xff00897B), size: 25), onPressed: () {
                          // _showHelpTypeDialog(context);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 155,
              child: Card(
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15),),
                elevation: 1,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20,),
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        keyboardType: TextInputType.multiline,
                        decoration: new InputDecoration.collapsed(
                            hintText: 'Message'
                        ),
                        onChanged: (term){
                          setState(() {
                            currentMessage = term;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Center(
                child: postingLoading ? ProgressLoading() : MyButton.myPrimaryButton("Submit", (){
                  setState(() {
                    postingLoading = true;
                  });
                  bloc.add(FetchService(selectedService.id, currentMessage, selectedHelpType.id, currentDate, currentTime));
                }),
              ),
            ),
            SizedBox(height: 30,),
            Divider(),
            SizedBox(height: 30,),
            selectedService.id == services[0].id ?
            ActivitiesView(_helpCenterListResponse) :
                MaintenanceActivities(_maintenanceListResponse)
          ],
        ),
      ),
    );
  }
}


class HelpType{
  String name;
  int id;

  HelpType(this.name, this.id);
}

class ServiceType{
  String name;
  String id;

  ServiceType(this.name, this.id);
}