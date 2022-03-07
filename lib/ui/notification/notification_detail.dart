import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/network/model/response/notification_response.dart';
import 'package:solar_kita/network/repository/service_repository.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/monitoring/services/service_bloc.dart';
import 'package:solar_kita/ui/monitoring/services/service_event.dart';
import 'package:solar_kita/ui/monitoring/services/service_state.dart';
import 'package:solar_kita/widget/my_snackbar.dart';
import 'package:solar_kita/widget/progress_loading.dart';

import 'notification_model.dart';

class NotificationDetailScreen extends StatelessWidget {

  Function(int) itemClick;


  NotificationDetailScreen({this.itemClick});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ServiceBloc>(
          create: (context) => ServiceBloc(ServiceRepositoryImpl()),
        ),
      ],
      child: NotificationScreenContent(itemClick),
    );
  }
}



class NotificationScreenContent extends StatefulWidget {
  Function(int) itemClick;


  NotificationScreenContent(this.itemClick);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreenContent> {


  ServiceBloc bloc;


  @override
  void initState() {
    bloc = BlocProvider.of<ServiceBloc>(context);
    bloc.add(FetchNotificationList());
  }


  List<Widget> generateNotif(){
    if(_notificationModel != null){
      return _notificationModel.data.map((e) => Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                    text: e.name,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              // MyText.myTextDescription2("10 mins ago", MyColors.grey_80),
              SizedBox(height: 10,),
              RichText(
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.grey_60, fontSize: 12.0, fontWeight: FontWeight.normal),
                  text:e.description,
                ),
              ),
              SizedBox(height: 20,),
              Divider(),
              InkWell(
                  onTap: (){
                    widget.itemClick(0);
                  },
                  child: Center(child: MyText.myTextHeader2("Find out more", MyColors.accentDark)))
            ],
          ),
        ),
      )).toList();
    }else{
      return [Container()];
    }

  }

  bool _isLoading = false;
  NotificationResponse _notificationModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServiceBloc,ServiceState>(
        listener: (context, state) async {
          if (state is LoadingState) {
            setState(() {
              _isLoading = true;
            });
          }else if (state is ServiceError) {
            setState(() {
              _isLoading = false;
              MySnackbar.errorSnackbar(context, state.message);
            });
          } else if(state is NotificationListLoaded){
            setState(() {
              _isLoading = false;
              _notificationModel = state.items;
            });
          }
        },
        child: Scaffold(
          body: _isLoading ? ProgressLoading() : ListView(
          children: generateNotif(),
          ),
          ),
    );

  }

}
