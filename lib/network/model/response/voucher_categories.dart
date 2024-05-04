// To parse this JSON data, do
//
//     final voucherCategoriesResponse = voucherCategoriesResponseFromJson(jsonString);

import 'dart:convert';

VoucherCategoriesResponse voucherCategoriesResponseFromJson(String str) => VoucherCategoriesResponse.fromJson(json.decode(str));

String voucherCategoriesResponseToJson(VoucherCategoriesResponse data) => json.encode(data.toJson());

class VoucherCategoriesResponse {
  VoucherCategoriesResponse({
    this.status,
    this.data,
  });

  int? status;
  List<Datum>? data;

  factory VoucherCategoriesResponse.fromJson(Map<String, dynamic> json) => VoucherCategoriesResponse(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.icon,
  });

  int? id;
  String? name;
  String? icon;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
  };
}
