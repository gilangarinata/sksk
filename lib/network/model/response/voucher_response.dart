// To parse this JSON data, do
//
//     final voucherResponse = voucherResponseFromJson(jsonString);

import 'dart:convert';

VoucherResponse voucherResponseFromJson(String str) => VoucherResponse.fromJson(json.decode(str));

String voucherResponseToJson(VoucherResponse data) => json.encode(data.toJson());

class VoucherResponse {
  VoucherResponse({
    this.status,
    this.data,
  });

  int? status;
  List<Datum>? data;

  factory VoucherResponse.fromJson(Map<String, dynamic> json) => VoucherResponse(
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
    this.code,
    this.merchantName,
    this.merchantType,
    this.merchantContact,
    this.koin,
    this.name,
    this.description,
    this.image,
    this.startDate,
    this.endDate,
    this.syarat,
    this.caraRedeem,
  });

  int? id;
  String? code;
  String? merchantName;
  String? merchantType;
  String? merchantContact;
  int? koin;
  String? name;
  String? description;
  String? image;
  DateTime? startDate;
  DateTime? endDate;
  String? syarat;
  String? caraRedeem;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    code: json["code"],
    merchantName: json["merchant_name"],
    merchantType: json["merchant_type"],
    merchantContact: json["merchant_contact"],
    koin: json["koin"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    syarat: json["syarat"],
    caraRedeem: json["cara_redeem"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "merchant_name": merchantName,
    "merchant_type": merchantType,
    "merchant_contact": merchantContact,
    "koin": koin,
    "name": name,
    "description": description,
    "image": image,
    "start_date": "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
    "syarat": syarat,
    "cara_redeem": caraRedeem,
  };
}
