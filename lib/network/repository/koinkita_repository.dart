import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/network/endpoints.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';
import 'package:solar_kita/network/model/response/koin_response.dart';
import 'package:solar_kita/network/model/response/response_redeem.dart';
import 'package:solar_kita/network/model/response/voucher_banner_response.dart';
import 'package:solar_kita/network/model/response/voucher_categories.dart';
import 'package:solar_kita/network/model/response/voucher_response.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/utils/tools.dart';

abstract class KoinKitaRepository {
  Future<KoinResponse> fetchKoin();
  Future<VoucherResponse> fetchVouchers();
  Future<VoucherResponse> fetchMyVouchers();
  Future<VoucherBannerResponse> fetchVoucherBanner();
  Future<VoucherCategoriesResponse> fetchVoucherCategories();
  Future<VoucherResponse> fetchVoucherCategoriesDetail(String id);
  Future<ResponseRedeem> postRedeem(String id);
}

class KoinKitaRepositoryImpl implements KoinKitaRepository {

  Future<String> _getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return "Bearer ${prefs.getString(PrefData.TOKEN)}";
  }

  @override
  Future<KoinResponse> fetchKoin() async {
    var headers = {
      "Authorization" : await _getToken()
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.KOIN,
    );
    try {
      print("uri: " +uri.toString());
      var response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 40));
      if (response.statusCode == 200) {
        KoinResponse results = koinResponseFromJson(response.body);
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
  Future<VoucherResponse> fetchVouchers() async {
    var headers = {
      "Authorization" : await _getToken()
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.VOUCHERS,
    );
    try {
      print("uri: " +uri.toString());
      Tools.stackTracer(
          StackTrace.current, "gilang1", 1000);
      var response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 40));

      Tools.stackTracer(
          StackTrace.current, "gilang2", 1000);
      if (response.statusCode == 200) {
        Tools.stackTracer(
            StackTrace.current, "gilang3", 1000);
        VoucherResponse results = voucherResponseFromJson(response.body);
        Tools.stackTracer(
            StackTrace.current, "gilang4", 1000);

        return results;
      } else {
        Tools.stackTracer(
            StackTrace.current, response.body, response.statusCode);
        throw Exception("---error");
      }
    } on TimeoutException catch (_) {
      Tools.stackTracer(
          StackTrace.current, "gilang", 1000);
      throw Exception("Timeout");
    } on SocketException catch (_) {
      Tools.stackTracer(
          StackTrace.current, "gilang", 1000);
      throw Exception("Socket exception");
    }
  }

  @override
  Future<VoucherResponse> fetchMyVouchers() async {
    var headers = {
      "Authorization" : await _getToken()
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.MY_VOUCHERS,
    );
    try {
      print("uri: " +uri.toString());
      var response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 40));
      if (response.statusCode == 200) {
        VoucherResponse results = voucherResponseFromJson(response.body);
        return results;
      } else {
        Tools.stackTracer(
            StackTrace.current, response.body, response.statusCode);
        throw Exception("---error");
      }
    } on TimeoutException catch (_) {
      Tools.stackTracer(
          StackTrace.current, "gilang", 1000);
      throw Exception("Timeout");
    } on SocketException catch (_) {
      Tools.stackTracer(
          StackTrace.current, "gilang", 1000);
      throw Exception("Socket exception");
    }
  }


  @override
  Future<VoucherBannerResponse> fetchVoucherBanner() async {
    var headers = {
      "Authorization" : await _getToken()
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.VOUCHER_BANNERS,
    );
    try {
      print("uri: " +uri.toString());
      var response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 40));
      if (response.statusCode == 200) {
        VoucherBannerResponse results = voucherBannerResponseFromJson(response.body);
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
  Future<VoucherCategoriesResponse> fetchVoucherCategories() async {
    var headers = {
      "Authorization" : await _getToken()
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.VOUCHER_CATEGORIES,
    );
    try {
      print("uri: " +uri.toString());
      var response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 40));
      if (response.statusCode == 200) {
        VoucherCategoriesResponse results = voucherCategoriesResponseFromJson(response.body);
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
  Future<ResponseRedeem> postRedeem(String id) async {
    var headers = {
      "Authorization" : await _getToken()
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.VOUCHERS + "/" + id,
    );
    try {
      print("uri: " +uri.toString());
      var response = await http.post(uri, headers: headers).timeout(
          const Duration(seconds: 40));
      if (response.statusCode == 200) {
        ResponseRedeem responseRedeem = responseRedeemFromJson(response.body);
        return responseRedeem;
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
  Future<VoucherResponse> fetchVoucherCategoriesDetail(String id) async {
    var headers = {
      "Authorization" : await _getToken()
    };
    var uri = Uri.https(
      Endpoints.BASE_URL_TEST,
      Endpoints.VOUCHER_CATEGORIES + "/" + id,
    );
    try {
      print("uri: " +uri.toString());
      var response = await http.get(uri, headers: headers).timeout(
          const Duration(seconds: 40));
      if (response.statusCode == 200) {
        VoucherResponse results = voucherResponseFromJson(response.body);
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
