// To parse this JSON data, do
//
//     final graphYearParentResponse = graphYearParentResponseFromJson(jsonString);

import 'dart:convert';

GraphYearParentResponse graphYearParentResponseFromJson(String str) => GraphYearParentResponse.fromJson(json.decode(str));

String graphYearParentResponseToJson(GraphYearParentResponse data) => json.encode(data.toJson());

class GraphYearParentResponse {
  GraphYearParentResponse({
    this.status,
    this.data,
  });

  int? status;
  List<GraphYearResponse>? data;

  factory GraphYearParentResponse.fromJson(Map<String, dynamic> json) => GraphYearParentResponse(
    status: json["status"],
    data: List<GraphYearResponse>.from(json["data"].map((x) => GraphYearResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
class GraphYearResponse {
  GraphYearResponse({
    this.serial,
    this.totalYear,
    this.monthI,
    this.yearI,
    this.dayHourAvg,
    this.powerMax,
  });

  String? serial;
  dynamic totalYear;
  String? monthI;
  String? yearI;
  String? dayHourAvg;
  String? powerMax;

  factory GraphYearResponse.fromJson(Map<String, dynamic> json) => GraphYearResponse(
    serial: json["Serial"],
    totalYear: json["TotalYear"],
    monthI: json["MonthI"],
    yearI: json["YearI"],
    dayHourAvg: json["DayHourAvg"] == null ? null : json["DayHourAvg"],
    powerMax: json["PowerMax"] == null ? null : json["PowerMax"],
  );

  Map<String, dynamic> toJson() => {
    "Serial": serial,
    "TotalYear": totalYear,
    "MonthI": monthI,
    "YearI": yearI,
    "DayHourAvg": dayHourAvg == null ? null : dayHourAvg,
    "PowerMax": powerMax == null ? null : powerMax,
  };
}
