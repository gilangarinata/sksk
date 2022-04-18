import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/network/endpoints.dart';
import 'package:solar_kita/network/keys.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';
import 'package:solar_kita/network/model/response/login_response.dart';
import 'package:solar_kita/network/model/response/profile_response.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/utils/tools.dart';

abstract class ProfileRepository {
  Future<ProfileResponse> getProfile();
  Future<bool> saveProfile(String name, String company);
  Future<bool> changePassword(String oldPassword, String newPassword, String newPassword2);
}

class ProfileRepositoryImpl implements ProfileRepository {
  Future<String> _getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return "Bearer " + prefs.getString(PrefData.TOKEN);
  }

  @override
  Future<ProfileResponse> getProfile() async {
    var headers = {
      "Authorization" : await _getToken()
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.PROFILE,
    );
    try {
      print("uri: " +uri.toString());
      var response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 40));
      if (response.statusCode == 200) {
        ProfileResponse results = profileResponseFromJson(response.body);
        return results;
      } else {
        Tools.stackTracer(
            StackTrace.current, response.body, response.statusCode);
        throw Exception("---error");
      }
    } on TimeoutException catch (_) {
      throw Exception("Timeout");
    } on SocketException catch (_) {
      throw Exception("Socket exception");
    }
  }

  @override
  Future<bool> saveProfile(String name, String company) async {
    var headers = {
      "Authorization": await _getToken()
    };
    var body = {
      "name": name,
      "company": company
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.PROFILE,
    );
    try {
      var response = await http.post(uri, headers: headers, body: body).timeout(
          const Duration(seconds: 40));
      if (response.statusCode == 200) {
        return true;
      } else {
        Tools.stackTracer(
            StackTrace.current, response.body, response.statusCode);
        throw Exception("---error");
      }
    } on TimeoutException catch (_) {
      throw Exception("Timeout");
    } on SocketException catch (_) {
      throw Exception("Socket exception");
    }
  }

  @override
  Future<bool> changePassword(String oldPassword, String newPassword, String newPassword2) async {
    var headers = {
      "Authorization": await _getToken()
    };
    var body = {
      "current_password": oldPassword,
      "new_password": newPassword,
      "new_password_confirmation" : newPassword2
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.CHANGE_PASSWORD,
    );
    try {
      var response = await http.post(uri, headers: headers, body: body).timeout(
          const Duration(seconds: 40));
      if (response.statusCode == 200) {
        return true;
      } else {
        Tools.stackTracer(
            StackTrace.current, response.body, response.statusCode);
        throw Exception("---error");
      }
    } on TimeoutException catch (_) {
      throw Exception("Timeout");
    } on SocketException catch (_) {
      throw Exception("Socket exception");
    }
  }
}
