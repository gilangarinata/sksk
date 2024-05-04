import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/network/endpoints.dart';
import 'package:solar_kita/network/keys.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';
import 'package:solar_kita/network/model/response/login_response.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/utils/tools.dart';

abstract class LoginRepository {
  Future<LoginResponse> processLogin(String username, String password);
}

class LoginRepositoryImpl implements LoginRepository {
  Future<void> _saveToken(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PrefData.TOKEN, token);
  }

  @override
  Future<LoginResponse> processLogin(String username, String password) async {
    final body = {
      'grant_type': 'password',
      'client_id': Keys.CLIENT_ID,
      'client_secret': Keys.CLIENT_SCREET,
      'username': username,
      'password': password,
    };
    var uri = Uri.https(
        Endpoints.BASE_URL_TEST,
        Endpoints.LOGIN,
    );
    print(uri);
    var response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      if (response.body != null) {
        try {
          LoginResponse results = loginResponseFromJson(response.body);
          _saveToken(results.accessToken ?? "");
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
      throw Exception("---error");
      Tools.stackTracer(StackTrace.current, response.body, response.statusCode);
    }
  }
}
