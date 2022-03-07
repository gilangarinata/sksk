// To parse this JSON data, do
//
//     final maintenanceListResponse = maintenanceListResponseFromJson(jsonString);

import 'dart:convert';

MaintenanceListResponse maintenanceListResponseFromJson(String str) => MaintenanceListResponse.fromJson(json.decode(str));

String maintenanceListResponseToJson(MaintenanceListResponse data) => json.encode(data.toJson());

class MaintenanceListResponse {
  MaintenanceListResponse({
    this.status,
    this.data,
  });

  int status;
  List<Datum> data;

  factory MaintenanceListResponse.fromJson(Map<String, dynamic> json) => MaintenanceListResponse(
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
    this.userId,
    this.nama,
    this.email,
    this.phone,
    this.address,
    this.date,
    this.time,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt
  });

  int id;
  int userId;
  String nama;
  String email;
  String phone;
  String address;
  DateTime date;
  String time;
  String message;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    nama: json["nama"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    message: json["message"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "nama": nama,
    "email": email,
    "phone": phone,
    "address": address,
    "date": date.toIso8601String(),
    "time": time,
    "message": message,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
