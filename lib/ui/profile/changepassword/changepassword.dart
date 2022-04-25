import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:solar_kita/widget/progress_loading.dart';

import '../profile_bloc.dart';
import '../profile_state.dart';

class ChangePasswordScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(ProfileRepositoryImpl()),
        ),
      ],
      child: ChangePasswordScreenContent(),
    );
  }
}


class ChangePasswordScreenContent extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreenContent> {

  ProfileBloc bloc;

  bool isLoading = false;

  TextEditingController oldController;
  TextEditingController newController;
  TextEditingController newController2;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ProfileBloc>(context);
    oldController = TextEditingController();
    newController = TextEditingController();
    newController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc,ProfileState>(
        listener: (context, state) async {
          if (state is LoadingState) {
            setState(() {
              isLoading = true;
            });
          }else if (state is ServiceError) {
            setState(() {
              isLoading = false;
              MySnackbar.showToast("Password was entered is incorrect");
            });
          }else if (state is ChangePasswordSuccess) {
            Fluttertoast.showToast(
                msg: "Change password success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: MyColors.grey_40,
                textColor: Colors.white,
                fontSize: 16.0
            ).then((value) => Navigator.pop(context));
          } else if (state is InitialState) {
            setState(() {
              isLoading = true;
            });
          }
        },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: MyColors.white,
          elevation: 0,
          centerTitle: true,

          title: MyText.myTextHeader2(MyStrings.changePass, MyColors.accentDark),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                controller: oldController,
                style: MyFieldStyle.myFieldStylePrimary(),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return MyStrings.mustNotEmpty;
                  }
                  return null;
                },
                cursorColor: MyColors.primary,
                decoration: InputDecoration(
                  labelText: MyStrings.oldPassword,
                  labelStyle: MyFieldStyle.myFieldLabelStylePrimary(),
                  enabledBorder: MyFieldStyle.myUnderlineFieldStyle(),
                  focusedBorder:
                  MyFieldStyle.myUnderlineFocusFieldStyle(),
                ),
              ),
              TextFormField(
                obscureText: true,
                controller: newController,
                style: MyFieldStyle.myFieldStylePrimary(),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return MyStrings.mustNotEmpty;
                  }
                  return null;
                },
                cursorColor: MyColors.primary,
                decoration: InputDecoration(
                  labelText: MyStrings.newPassword,
                  labelStyle: MyFieldStyle.myFieldLabelStylePrimary(),
                  enabledBorder: MyFieldStyle.myUnderlineFieldStyle(),
                  focusedBorder:
                  MyFieldStyle.myUnderlineFocusFieldStyle(),
                ),
              ),
              TextFormField(
                obscureText: true,
                controller: newController2,
                style: MyFieldStyle.myFieldStylePrimary(),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return MyStrings.mustNotEmpty;
                  }
                  return null;
                },
                cursorColor: MyColors.primary,
                decoration: InputDecoration(
                  labelText: MyStrings.reEnterNewPassword,
                  labelStyle: MyFieldStyle.myFieldLabelStylePrimary(),
                  enabledBorder: MyFieldStyle.myUnderlineFieldStyle(),
                  focusedBorder:
                  MyFieldStyle.myUnderlineFocusFieldStyle(),
                ),
              ),
              SizedBox(height: 100,),
              isLoading ? ProgressLoading() : MyButton.myPrimaryButton(MyStrings.save, (){
                var oldPass = oldController.text.toString();
                var newPass = newController.text.toString();
                var newPass2 = newController2.text.toString();
                if(oldPass.isNotEmpty && newPass.isNotEmpty && newPass2.isNotEmpty){
                  bloc.add(ChangePassword(oldPass, newPass, newPass2));
                }else{
                  MySnackbar.showToast("Data not complete");
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
