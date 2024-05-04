// To parse this JSON data, do
//
//     final helpCenterListResponse = helpCenterListResponseFromJson(jsonString);

import 'dart:convert';

HelpCenterListResponse helpCenterListResponseFromJson(String str) => HelpCenterListResponse.fromJson(json.decode(str));

String helpCenterListResponseToJson(HelpCenterListResponse data) => json.encode(data.toJson());

class HelpCenterListResponse {
  HelpCenterListResponse({
    this.status,
    this.data,
  });

  int? status;
  List<Datum>? data;

  factory HelpCenterListResponse.fromJson(Map<String, dynamic> json) => HelpCenterListResponse(
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
    this.complaintTypeId,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.date,
    this.time
  });

  int? id;
  int? complaintTypeId;
  int? userId;
  Name? name;
  Email? email;
  String? phone;
  Address? address;
  String? message;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? date;
  String? time;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    complaintTypeId: json["complaint_type_id"],
    userId: json["user_id"],
    name: nameValues.map?[json["name"]],
    email: emailValues.map?[json["email"]],
    phone: json["phone"],
    address: addressValues.map?[json["address"]],
    message: json["message"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]).toLocal(),
    updatedAt: DateTime.parse(json["updated_at"]),
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "complaint_type_id": complaintTypeId,
    "user_id": userId,
    "name": nameValues.reverse?[name],
    "email": emailValues.reverse?[email],
    "phone": phone,
    "address": addressValues.reverse?[address],
    "message": message,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

enum Address { JALAN_JALAN }

final addressValues = EnumValues({
  "jalan jalan": Address.JALAN_JALAN
});

enum Email { TAUFANPR22_GMAIL_COM }

final emailValues = EnumValues({
  "taufanpr22@gmail.com": Email.TAUFANPR22_GMAIL_COM
});

enum Name { TAUFAN_PRASETYO }

final nameValues = EnumValues({
  "Taufan Prasetyo": Name.TAUFAN_PRASETYO
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map?.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
