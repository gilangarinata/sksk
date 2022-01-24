// To parse this JSON data, do
//
//     final graphTotalParentResponse = graphTotalParentResponseFromJson(jsonString);

import 'dart:convert';

GraphTotalParentResponse graphTotalParentResponseFromJson(String str) => GraphTotalParentResponse.fromJson(json.decode(str));

String graphTotalParentResponseToJson(GraphTotalParentResponse data) => json.encode(data.toJson());

class GraphTotalParentResponse {
  GraphTotalParentResponse({
    this.status,
    this.data,
  });

  int status;
  List<GraphTotalResponse> data;

  factory GraphTotalParentResponse.fromJson(Map<String, dynamic> json) => GraphTotalParentResponse(
    status: json["status"],
    data: List<GraphTotalResponse>.from(json["data"].map((x) => GraphTotalResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
class GraphTotalResponse {
  GraphTotalResponse({
    this.serial,
    this.total,
    this.yearI,
  });

  String serial;
  dynamic total;
  String yearI;

  factory GraphTotalResponse.fromJson(Map<String, dynamic> json) => GraphTotalResponse(
    serial: json["Serial"],
    total: json["Total"],
    yearI: json["YearI"],
  );

  Map<String, dynamic> toJson() => {
    "Serial": serial,
    "Total": total,
    "YearI": yearI,
  };
}
