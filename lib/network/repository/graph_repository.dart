import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/network/endpoints.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/utils/tools.dart';

abstract class GraphRepository {
  Future<List<GraphDayResponse>> fetchGraphDaily(String date, String inverterId);
  Future<List<GraphMonthResponse>> fetchGraphMonthly(String month, String inverterId);
  Future<List<GraphYearResponse>> fetchGraphYearly(String year, String inverterId);
  Future<List<GraphTotalResponse>> fetchGraphTotal(String inverterId);
}

class GraphRepositoryImpl implements GraphRepository {

  Future<String> _getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return "Bearer " + prefs.getString(PrefData.TOKEN);
  }

  @override
  Future<List<GraphDayResponse>> fetchGraphDaily(String date , String inverterId) async {
    var headers = {
      "Authorization" : await _getToken()
    };

    final body = {
      'serial': inverterId,
      'date': date,
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.GRAPH_DAILY,
    );

    print(uri);

    var response = await http.post(uri, body: body, headers: headers).timeout(const Duration(seconds: 10));
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body != null) {
        try {
          List<GraphDayResponse> results = graphDayParentResponseFromJson(response.body).data;
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
      Tools.stackTracer(StackTrace.current, response.body, response.statusCode);
    }
  }

  @override
  Future<List<GraphMonthResponse>> fetchGraphMonthly(String month, String inverterId) async {
    var headers = {
      "Authorization" : await _getToken()
    };
    final body = {
      'serial': inverterId,
      'month': month,
    };
    var uri = Uri.https(
        Endpoints.BASE_URL_TEST,
        Endpoints.GRAPH_MONTHLY
    );

    var response = await http.post(uri, body:body, headers: headers ).timeout(const Duration(seconds: 10));
    print(uri);
    if (response.statusCode == 200) {
      if (response.body != null) {
        try {
          List<GraphMonthResponse> results = graphMonthParentResponseFromJson(response.body).data;
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
      Tools.stackTracer(StackTrace.current, response.body, response.statusCode);
    }
  }

  @override
  Future<List<GraphTotalResponse>> fetchGraphTotal(String inverterId) async {
    var headers = {
      "Authorization" : await _getToken()
    };
    final body = {
      'serial': inverterId,
    };
    var uri = Uri.https(
        Endpoints.BASE_URL_TEST,
        Endpoints.GRAPH_TOTAL
    );

    var response = await http.post(uri, body: body, headers: headers).timeout(const Duration(seconds: 10));
    print(uri);
    if (response.statusCode == 200) {
      if (response.body != null) {
        try {
          List<GraphTotalResponse> results = graphTotalParentResponseFromJson(response.body).data;
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
      Tools.stackTracer(StackTrace.current, response.body, response.statusCode);
    }
  }

  @override
  Future<List<GraphYearResponse>> fetchGraphYearly(String year, String inverterId) async {
    var headers = {
      "Authorization" : await _getToken()
    };
    final body = {
      'serial': inverterId,
      'year': year,
    };
    var uri = Uri.https(
        Endpoints.BASE_URL_TEST,
        Endpoints.GRAPH_YEARLY,
    );

    var response = await http.post(uri,body: body, headers: headers).timeout(const Duration(seconds: 10));
    print(uri);
    if (response.statusCode == 200) {
      if (response.body != null) {
        try {
          List<GraphYearResponse> results = graphYearParentResponseFromJson(response.body).data;
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
      Tools.stackTracer(StackTrace.current, response.body, response.statusCode);
    }
  }
}
