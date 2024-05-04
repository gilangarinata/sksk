// To parse this JSON data, do
//
//     final graphDayResponse = graphDayResponseFromJson(jsonString);

import 'dart:convert';

GraphDayParentResponse graphDayParentResponseFromJson(String str) => GraphDayParentResponse.fromJson(json.decode(str));

String graphDayParentResponseToJson(GraphDayParentResponse data) => json.encode(data.toJson());

class GraphDayParentResponse {
  GraphDayParentResponse({
    this.status,
    this.data,
  });

  int? status;
  List<GraphDayResponse>? data;

  factory GraphDayParentResponse.fromJson(Map<String, dynamic> json) => GraphDayParentResponse(
    status: json["status"],
    data: List<GraphDayResponse>.from(json["data"].map((x) => GraphDayResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GraphDayResponse {
  GraphDayResponse({
    this.timeStamp,
    this.serial,
    this.totalYield,
    this.power,
    this.dateI,
    this.timeI,
    this.powerPct,
    this.pVoutput,
  });

  dynamic timeStamp;
  String? serial;
  dynamic totalYield;
  double? power;
  DateTime? dateI;
  String? timeI;
  dynamic powerPct;
  int? pVoutput;

  factory GraphDayResponse.fromJson(Map<String, dynamic> json) => GraphDayResponse(
    timeStamp: json["TimeStamp"],
    serial: json["Serial"],
    totalYield: json["TotalYield"],
    power: json["Power"].toDouble(),
    dateI: DateTime.parse(json["DateI"]),
    timeI: json["TimeI"],
    powerPct: json["PowerPct"],
    pVoutput: json["PVoutput"] == null ? null : json["PVoutput"],
  );

  Map<String, dynamic> toJson() => {
    "TimeStamp": timeStamp,
    "Serial": serial,
    "TotalYield": totalYield,
    "Power": power,
    "DateI": "${dateI?.year.toString().padLeft(4, '0')}-${dateI?.month.toString().padLeft(2, '0')}-${dateI?.day.toString().padLeft(2, '0')}",
    "TimeI": timeI,
    "PowerPct": powerPct,
    "PVoutput": pVoutput == null ? null : pVoutput,
  };
}
