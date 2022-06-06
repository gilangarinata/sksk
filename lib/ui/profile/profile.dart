import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/network/model/response/profile_response.dart';
import 'package:solar_kita/network/repository/profile_repository.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/koinkita/koinkita.dart';
import 'package:solar_kita/ui/login/login_screen.dart';
import 'package:solar_kita/ui/monitoring/Monitoring.dart';
import 'package:solar_kita/ui/profile/changepassword/changepassword.dart';
import 'package:solar_kita/ui/profile/contactus.dart';
import 'package:solar_kita/ui/profile/faq/faq.dart';
import 'package:solar_kita/ui/profile/privacypolicy.dart';
import 'package:solar_kita/ui/profile/profile_bloc.dart';
import 'package:solar_kita/ui/profile/profile_event.dart';
import 'package:solar_kita/ui/profile/profile_state.dart';
import 'package:solar_kita/ui/profile/termconditions.dart';
import 'package:solar_kita/ui/profile/updateprofile/updateprofile.dart';
import 'package:solar_kita/utils/tools.dart';
import 'package:solar_kita/widget/my_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(ProfileRepositoryImpl()),
        ),
      ],
      child: ProfileScreenContent(),
    );
  }
}


class ProfileScreenContent extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreenContent> {

  _launchWhatsapp() async {
    const url = "https://api.whatsapp.com/send/?phone=%2B6281311269988&text&app_absent=0";
    await launch(url);
  }

  ProfileBloc bloc;
  String selectedProfileImage = "";

  void getSelectedProfileImage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedProfileImage = prefs.getString("AVATAR-IMAGE");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of<ProfileBloc>(context);
    bloc.add(FetchProfile());
    getSelectedProfileImage();
  }

  ProfileResponse profileResponse;


  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc,ProfileState>(
      listener: (context, state) async {
        if (state is LoadingState) {
          setState(() {
            // _isLoading = true;
          });
        }else if (state is ServiceError) {
          setState(() {
            // _isLoading = false;
            MySnackbar.errorSnackbar(context, state.message);
          });
        } else if(state is ProfileLoaded){
          setState(() {
            // _isLoading = false;
            profileResponse = state.items;
          });
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/header_profile.png",width: double.infinity,),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios,color: MyColors.accentDark,),
                      ),
                      Spacer(),
                      MyText.myTextHeader2(MyStrings.myAccount, MyColors.accentDark),
                      Spacer(),
                      SizedBox(width: 50,)
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                    padding: const EdgeInsets.only(top: 50 ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          child: ClipRRect(
                            borderRadius:BorderRadius.circular(50),
                            child: selectedProfileImage == null ? Image.asset("assets/avatar1.png")  : Image.asset(selectedProfileImage),
                          ),
                          radius: 40,
                          backgroundColor: MyColors.accentDark,
                        ),
                        SizedBox(height: 10,),
                        MyText.myTextHeader2(profileResponse != null ? profileResponse.data.name : "", MyColors.accentDark),
                        MyText.myTextHeader3(profileResponse != null ? profileResponse.data.email : "", MyColors.accentDark)
                      ],
                    )
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: ListView(
                    children: [
                      Divider(),
                      InkWell(
                        onTap: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          bool isDemo = prefs.getBool(PrefData.IS_DEMO);

                          if(isDemo){
                            MySnackbar.showToast("Not Available. You are using demo account.");
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateProfileScreen(profileResponse),
                            ),
                          ).then((value) {
                            getSelectedProfileImage();
                            bloc.add(FetchProfile());
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: MyText.myTextHeader2(MyStrings.updateProfile, MyColors.grey_80),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          bool isDemo = prefs.getBool(PrefData.IS_DEMO);

                          if(isDemo){
                            MySnackbar.showToast("Not Available. You are using demo account.");
                            return;
                          }
                          Tools.addScreen(context, ChangePasswordScreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: MyText.myTextHeader2(MyStrings.changePass, MyColors.grey_80),
                        ),
                      ),
                      Divider(thickness: 5,color: MyColors.grey_5,),
                      InkWell(
                        onTap: (){
                          Tools.addScreen(context, TermAndConditionScreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: MyText.myTextHeader2(MyStrings.termsCondition, MyColors.grey_80),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: (){
                          Tools.addScreen(context, PrivacyPolicyScreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: MyText.myTextHeader2(MyStrings.privacyPolicy, MyColors.grey_80),
                        ),
                      ),
                      Divider(thickness: 5,color: MyColors.grey_5,),
                      InkWell(
                        onTap: (){
                          Tools.addScreen(context, FaqScreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: MyText.myTextHeader2(MyStrings.faq, MyColors.grey_80),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: (){
                          _launchWhatsapp();
                          // Tools.addScreen(context, ContactUsScreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: MyText.myTextHeader2(MyStrings.contactUs, MyColors.grey_80),
                        ),
                      ),
                      Divider(thickness: 5,color: MyColors.grey_5,),
                      InkWell(
                        onTap: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          Tools.changeScreen(context, LoginScreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          child: MyText.myTextHeader2(MyStrings.logout, Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );

  }
}
