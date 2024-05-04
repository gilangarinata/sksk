import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/network/model/response/profile_response.dart';
import 'package:solar_kita/network/repository/profile_repository.dart';
import 'package:solar_kita/res/my_button.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_field_style.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/koinkita/koinkita.dart';
import 'package:solar_kita/ui/monitoring/Monitoring.dart';
import 'package:solar_kita/ui/profile/profile_event.dart';
import 'package:solar_kita/widget/my_snackbar.dart';

import '../profile_bloc.dart';
import '../profile_state.dart';


class UpdateProfileScreen extends StatelessWidget {
  ProfileResponse profileResponse;


  UpdateProfileScreen(this.profileResponse);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(ProfileRepositoryImpl()),
        ),
      ],
      child: UpdateProfileScreenContent(profileResponse),
    );
  }
}


class UpdateProfileScreenContent extends StatefulWidget {

  ProfileResponse profileResponse;


  UpdateProfileScreenContent(this.profileResponse);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreenContent> {

  int selectedProfile = 0;
  String selectedProfileImage = "";
  ProfileBloc? bloc;
  TextEditingController? nameController;
  TextEditingController? companyController;

  void getSelectedProfileImage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedProfileImage = prefs.getString("AVATAR-IMAGE")!;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profileResponse != null ? widget.profileResponse.data!.name : "");
    companyController = TextEditingController(text: widget.profileResponse != null ? widget.profileResponse.data!.company : "");
    bloc = BlocProvider.of<ProfileBloc>(context);
    getSelectedProfile();
    getSelectedProfileImage();
  }

  void getSelectedProfile() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedProfile = prefs.getInt("AVATAR")!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc,ProfileState?>(
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
          } else if(state is SaveSuccess){
            setState(() {
              // _isLoading = false;
              Navigator.pop(context);
            });
          }
        },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: MyText.myTextHeader2(MyStrings.updateProfile, MyColors.accentDark),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: CircleAvatar(
                                      radius: 50,
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(50),
                                        child: Image.asset("assets/avatar1.png"),
                                      ),
                                    ),
                                    onTap: () async{
                                      setState(() {
                                        selectedProfile = 0;
                                      });
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString("AVATAR-IMAGE", "assets/avatar1.png");
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: MyColors.accentDark,
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(50),
                                        child: Image.asset("assets/avatar2.png"),
                                      ),
                                    ),
                                    onTap: () async{
                                      setState(() {
                                        selectedProfile = 1;
                                      });
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString("AVATAR-IMAGE", "assets/avatar2.png");
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: MyColors.accentDark,
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(50),
                                        child: Image.asset("assets/avatar3.png"),
                                      ),
                                    ),
                                    onTap: () async{
                                      setState(() {
                                        selectedProfile = 2;
                                      });
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString("AVATAR-IMAGE", "assets/avatar3.png");
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: MyColors.accentDark,
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(50),
                                        child: Image.asset("assets/avatar4.png"),
                                      ),
                                    ),
                                    onTap: () async{
                                      setState(() {
                                        selectedProfile = 3;
                                      });
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString("AVATAR-IMAGE", "assets/avatar4.png");
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                          ],
                        );
                      }).then((value) {
                    getSelectedProfileImage();
                  });
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: MyColors.accentDark,
                  child: ClipRRect(
                    borderRadius:BorderRadius.circular(50),
                    child: selectedProfileImage == null ? Image.asset("assets/avatar1.png")  : Image.asset(selectedProfileImage),
                  ),
                ),
              ),
              TextFormField(
                controller: nameController,
                style: MyFieldStyle.myFieldStylePrimary(),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.mustNotEmpty;
                  }
                  return null;
                },
                cursorColor: MyColors.primary,
                decoration: InputDecoration(
                  icon: Container(
                      child:
                      Icon(Icons.person, color: MyColors.grey_60),
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                  labelText: MyStrings.name,
                  labelStyle: MyFieldStyle.myFieldLabelStylePrimary(),
                  enabledBorder: MyFieldStyle.myUnderlineFieldStyle(),
                  focusedBorder:
                  MyFieldStyle.myUnderlineFocusFieldStyle(),
                ),
              ),
              TextFormField(
                controller: companyController,
                style: MyFieldStyle.myFieldStylePrimary(),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.mustNotEmpty;
                  }
                  return null;
                },
                cursorColor: MyColors.primary,
                decoration: InputDecoration(
                  icon: Container(
                      child:
                      Icon(Icons.business, color: MyColors.grey_60),
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                  labelText: MyStrings.company,
                  labelStyle: MyFieldStyle.myFieldLabelStylePrimary(),
                  enabledBorder: MyFieldStyle.myUnderlineFieldStyle(),
                  focusedBorder:
                  MyFieldStyle.myUnderlineFocusFieldStyle(),
                ),
              ),
              TextFormField(
                enabled: false,
                initialValue: widget.profileResponse != null ? widget.profileResponse.data!.email : "",
                style: MyFieldStyle.myFieldStylePrimary(),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.mustNotEmpty;
                  }
                  return null;
                },
                cursorColor: MyColors.primary,
                decoration: InputDecoration(
                  icon: Container(
                      child:
                      Icon(Icons.email, color: MyColors.grey_60),
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                  labelText: MyStrings.email,
                  labelStyle: MyFieldStyle.myFieldLabelStylePrimary(),
                  enabledBorder: MyFieldStyle.myUnderlineFieldStyle(),
                  focusedBorder:
                  MyFieldStyle.myUnderlineFocusFieldStyle(),
                ),
              ),
              SizedBox(height: 100,),
              MyButton.myPrimaryButton(MyStrings.save, (){
                var name = nameController!.text.toString();
                var company = companyController!.text.toString();
                bloc?.add(SaveProfile(name, company));
              })
            ],
          ),
        ),
      ),
    );
  }
}
