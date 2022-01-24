// To parse this JSON data, do
//
//     final voucherBannerResponse = voucherBannerResponseFromJson(jsonString);

import 'dart:convert';

VoucherBannerResponse voucherBannerResponseFromJson(String str) => VoucherBannerResponse.fromJson(json.decode(str));

String voucherBannerResponseToJson(VoucherBannerResponse data) => json.encode(data.toJson());

class VoucherBannerResponse {
  VoucherBannerResponse({
    this.status,
    this.data,
  });

  int status;
  List<Datum> data;

  factory VoucherBannerResponse.fromJson(Map<String, dynamic> json) => VoucherBannerResponse(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.image,
    this.redirect_url
  });

  int id;
  String name;
  String image;
  String redirect_url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    redirect_url: json["redirect_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
