import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/network/endpoints.dart';
import 'package:solar_kita/network/keys.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';
import 'package:solar_kita/network/model/response/login_response.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/ui/login/login_screen.dart';
import 'package:solar_kita/utils/tools.dart';

abstract class SystemProfileRepository {
  Future<SystemProfileResponse> getSystemProfile();
  Future<SystemProfileResponse> getSystemProfileDetail(String id);
}

class SystemProfileRepositoryImpl implements SystemProfileRepository {

  BuildContext context;

  SystemProfileRepositoryImpl(this.context);

  Future<String> _getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return "Bearer " + prefs.getString(PrefData.TOKEN);
  }

  Future<void> _clearPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _logout(){
    _clearPreferences();
    Tools.changeScreen(context, LoginScreen());
  }

  @override
  Future<SystemProfileResponse> getSystemProfile() async {
    var token = await _getToken();
    var headers = {
      "Authorization" : token
    };

    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.SYSTEM_PROFILE,
    );

    var response = await http.get(uri, headers: headers);
    print(uri);
    if (response.statusCode == 200) {
      if (response.body != null) {
        try {
          SystemProfileResponse results = systemProfileResponseFromJson(response.body);
          Tools.stackTracer(StackTrace.current, "Sukses", response.statusCode);
          return results;
        } catch (e) {
          Tools.stackTracer(StackTrace.current, e.toString(), 500);
          throw Exception("---parseFailed");
        }
      } else {
        Tools.stackTracer(StackTrace.current, "Error", 501);
        throw Exception("---noData");
      }
    } else {
      if(response.statusCode == 401){
        _logout();
        throw Exception("Unauthorized");
      }
      Tools.stackTracer(StackTrace.current, response.body, response.statusCode);
    }
  }

  @override
  Future<SystemProfileResponse> getSystemProfileDetail(String id) async {
    var token = await _getToken();
    var headers = {
      "Authorization" : token
    };

    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.SYSTEM_PROFILE_DETAIL + id,
    );

    var response = await http.get(uri, headers: headers);
    print(uri);
    if (response.statusCode == 200) {
      if (response.body != null) {
        try {
          SystemProfileResponse results = systemProfileResponseFromJson(response.body);
          Tools.stackTracer(StackTrace.current, "Sukses", response.statusCode);
          return results;
        } catch (e) {
          Tools.stackTracer(StackTrace.current, e.toString(), 500);
          throw Exception("---parseFailed");
        }
      } else {
        _logout();
        Tools.stackTracer(StackTrace.current, "Error", 501);
        throw Exception("---noData");
      }
    } else {
      if(response.statusCode == 401){
        throw Exception("Unauthorized");
      }
      Tools.stackTracer(StackTrace.current, response.body, response.statusCode);
    }
  }

}
