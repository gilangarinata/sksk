// To parse this JSON data, do
//
//     final responseRedeem = responseRedeemFromJson(jsonString);

import 'dart:convert';

ResponseRedeem responseRedeemFromJson(String str) => ResponseRedeem.fromJson(json.decode(str));

String responseRedeemToJson(ResponseRedeem data) => json.encode(data.toJson());

class ResponseRedeem {
  ResponseRedeem({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory ResponseRedeem.fromJson(Map<String, dynamic> json) => ResponseRedeem(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
