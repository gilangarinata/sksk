import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/network/endpoints.dart';
import 'package:solar_kita/network/keys.dart';
import 'package:solar_kita/network/model/response/help_center_list_response.dart';
import 'package:solar_kita/network/model/response/maintenance_list_response.dart';
import 'package:solar_kita/network/model/response/notification_response.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/utils/tools.dart';

abstract class ServiceRepository {
  Future<bool> postService(String type, String message, int helpTypeId, String date, String time);
  Future<HelpCenterListResponse> getHelpCenterList();
  Future<MaintenanceListResponse> getMaintenanceList();
  Future<NotificationResponse> getNotificationList();
}

class ServiceRepositoryImpl implements ServiceRepository {

  Future<String> _getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return "Bearer ${prefs.getString(PrefData.TOKEN)}";
  }

  @override
  Future<bool> postService(String type, String message, int helpTypeId, String date, String time) async {
    var headers = {
      "Authorization" : await _getToken()
    };
    final body = {
      'type': type,
      'message': message,
      'help_type_id': helpTypeId.toString(),
      'date': date,
      'time': time,
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.SERVICES,
    );
    print("body");
    print(body);
    try {
      var response = await http.post(uri, body: body, headers: headers).timeout(
          const Duration(seconds: 40));

      print("res: " +response.toString());
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
  Future<HelpCenterListResponse> getHelpCenterList() async {
    var headers = {
      "Authorization" : await _getToken()
    };

    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.HELP_CENTER_LIST,
    );
    try {
      var response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 40));

      print("res: " +response.toString());
      if (response.statusCode == 200) {
        HelpCenterListResponse results = helpCenterListResponseFromJson(response.body);
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
  Future<MaintenanceListResponse> getMaintenanceList() async {
    var headers = {
      "Authorization" : await _getToken()
    };

    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.MAINTENANCE_LIST,
    );
    try {
      print("uri: " +uri.toString());
      var response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 40));
      if (response.statusCode == 200) {

        MaintenanceListResponse results = maintenanceListResponseFromJson(response.body);
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
  Future<NotificationResponse> getNotificationList() async {
    var headers = {
      "Authorization" : await _getToken()
    };

    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.NOTIF,
    );
    try {
      print("uri: " +uri.toString());
      var response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 40));
      if (response.statusCode == 200) {

        NotificationResponse results = notificationModelFromJson(response.body);
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
}
