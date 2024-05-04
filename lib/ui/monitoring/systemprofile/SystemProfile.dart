import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';
import 'package:solar_kita/network/repository/system_profile_repository.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/mysolarsystem/MySolarSystem.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/systemprofile_bloc.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/systemprofile_event.dart';
import 'package:solar_kita/ui/monitoring/systemprofile/systemprofile_state.dart';
import 'package:solar_kita/widget/my_snackbar.dart';
import 'package:solar_kita/widget/progress_loading.dart';


class SystemProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SystemProfileBloc>(
          create: (context) => SystemProfileBloc(SystemProfileRepositoryImpl(context)),
        ),
      ],
      child: SystemProfileChild(),
    );
  }
}


class SystemProfileChild extends StatefulWidget {
  @override
  _SystemProfileChildState createState() => _SystemProfileChildState();
}

class _SystemProfileChildState extends State<SystemProfileChild> with SingleTickerProviderStateMixin{

  late SystemProfileBloc bloc;
  bool _isLoading = true;
  late SystemProfileResponse response;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SystemProfileBloc>(context);
    bloc.add(FetchSystemProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      color: MyColors.white,
      child: BlocListener<SystemProfileBloc,SystemProfileState?>(
        listener: (context, state) async {
          if (state is SystemProfileError) {
            setState(() {
              _isLoading = false;
              MySnackbar.errorSnackbar(context, state.message);
            });
          } else if (state is SystemProfileLoaded) {
            setState(() {
              _isLoading = false;
              response = state.items;
            });
          }
        },
        child: Center(
          child: _isLoading ? ProgressLoading() : ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: MyColors.primary,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      MyText.myTextHeader2(MyStrings.todaysProduction, MyColors.accentDark),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyText.bigText(response != null ? response.data!.todayProduction.toString() : "", MyColors.accentDark),
                          MyText.myTextDescription(MyStrings.kwh, MyColors.accentDark)
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
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        child: Column(
                          children: [
                            MyText.myTextHeader2(MyStrings.monthEnergy, MyColors.accentDark),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyText.bigText(response != null ? response.data!.monthlyEnergy.toString() : "", MyColors.accentDark),
                                MyText.myTextDescription(MyStrings.kwh, MyColors.accentDark)
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
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        child: Column(
                          children: [
                            MyText.myTextHeader2(MyStrings.monthSaving, MyColors.accentDark),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyText.myTextDescription(MyStrings.rp, MyColors.accentDark),
                                MyText.bigText(response != null ? response.data!.monthlySaving.toString() : "", MyColors.accentDark),
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
                    border: Border.all(color: MyColors.accentDark,width: 2)
                ),
                child: Center(child: MyText.myTextHeader2("CO2 Reduced = " + (response != null ? response.data!.co2Reduced.toString() : "") + "kg", MyColors.accentDark)),
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
                      Expanded(child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText.myTextDescription2(MyStrings.totalEnergy, MyColors.accentDark),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText.myTextHeader1(response != null ? response.data!.totalEnergy.toString() : "", MyColors.accentDark),
                                SizedBox(width: 5,),
                                MyText.myTextDescription2(MyStrings.kwh, MyColors.accentDark)
                              ],
                            )
                          ],
                        ),
                      )),
                      Expanded(child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText.myTextDescription2(MyStrings.totalSaving, MyColors.accentDark),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText.myTextDescription2(MyStrings.rp, MyColors.accentDark),
                                    SizedBox(width: 5,),
                                    MyText.myTextHeader1(response != null ? response.data!.totalSaving.toString() : "", MyColors.accentDark),
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
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              MySolarSystemView(response)
            ],
          ),
        ),
      ),
    );
  }
}
