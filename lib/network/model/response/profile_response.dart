// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    this.status,
    this.data,
  });

  int status;
  Data data;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => ProfileResponse(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.name,
    this.company,
    this.email,
  });

  String name;
  String company;
  String email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    company: json["company"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "company": company,
    "email": email,
  };
}
