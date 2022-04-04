import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_kita/network/repository/login_repository.dart';
import 'package:solar_kita/res/my_button.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_field_style.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/dashboard.dart';
import 'package:solar_kita/ui/login/login_bloc.dart';
import 'package:solar_kita/ui/login/login_event.dart';
import 'package:solar_kita/ui/login/login_state.dart';
import 'package:solar_kita/ui/profile/forgotpassword.dart';
import 'package:solar_kita/utils/tools.dart';
import 'package:solar_kita/utils/validator.dart';
import 'package:solar_kita/widget/my_snackbar.dart';
import 'package:solar_kita/widget/progress_loading.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(LoginRepositoryImpl()),
        ),
      ],
      child: LoginScreenChild(),
    );
  }
}

class LoginScreenChild extends StatefulWidget {
  @override
  _LoginScreenChildState createState() => _LoginScreenChildState();
}

class _LoginScreenChildState extends State<LoginScreenChild> {

  LoginBloc loginBloc;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: BlocListener<LoginBloc,LoginState>(
        listener: (context, state) async {
          if (state is LoginError) {
            setState(() {
              _isLoading = false;
              MySnackbar.errorSnackbar(context, state.message);
            });
          } else if (state is LoginSuccess) {
            setState(() {
              _isLoading = false;
              Tools.changeScreen(context, DashboardScreen());
            });
          }else if (state is LoadingState) {
            setState(() {
              _isLoading = true;
            });
          }
        },
        child: Container(
          child: ListView(
            children: [
              Image.asset('assets/header.png'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.myTextHeader1(MyStrings.welcome, MyColors.accentDark),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: _usernameController,
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
                        icon: Container(
                            child:
                            Icon(Icons.person, color: MyColors.grey_60),
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: MyStrings.emailUserName,
                        labelStyle: MyFieldStyle.myFieldLabelStylePrimary(),
                        enabledBorder: MyFieldStyle.myUnderlineFieldStyle(),
                        focusedBorder:
                        MyFieldStyle.myUnderlineFocusFieldStyle(),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      style: MyFieldStyle.myFieldStylePrimary(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return MyStrings.mustNotEmpty;
                        } else {
                          if (!Validator.passwordValidation(value)) {
                            return MyStrings.atleast5;
                          }
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      cursorColor: MyColors.primary,
                      decoration: InputDecoration(
                        icon: Container(
                            child: Icon(Icons.vpn_key,
                                color: MyColors.grey_60),
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                        labelText: MyStrings.password,
                        labelStyle: MyFieldStyle.myFieldLabelStylePrimary(),
                        enabledBorder: MyFieldStyle.myUnderlineFieldStyle(),
                        focusedBorder:
                        MyFieldStyle.myUnderlineFocusFieldStyle(),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        _isLoading ? ProgressLoading() : MyButton.myPrimaryButton(
                          MyStrings.login,
                              () {
                            setState(() {
                              _isLoading = true;
                              var username = _usernameController.text.toString();
                              var password = _passwordController.text.toString();
                              loginBloc.add(ProcessLogin(username, password));
                            });
                          },
                        ),
                        Spacer(),
                        InkWell(
                            onTap: (){
                              Tools.addScreen(context, ForgotPassword());
                            },
                            child: MyText.myTextDescription(MyStrings.forgotPass, Colors.red))
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
