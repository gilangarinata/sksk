// To parse this JSON data, do
//
//     final koinResponse = koinResponseFromJson(jsonString);

import 'dart:convert';

KoinResponse koinResponseFromJson(String str) => KoinResponse.fromJson(json.decode(str));

String koinResponseToJson(KoinResponse data) => json.encode(data.toJson());

class KoinResponse {
  KoinResponse({
    this.status,
    this.data,
  });

  int? status;
  Data? data;

  factory KoinResponse.fromJson(Map<String, dynamic> json) => KoinResponse(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.availableKoin,
  });

  String? availableKoin;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    availableKoin: json["available_koin"] ,
  );

  Map<String, dynamic> toJson() => {
    "available_koin": availableKoin,
  };
}
