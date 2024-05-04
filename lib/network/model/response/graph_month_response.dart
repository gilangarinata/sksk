// To parse this JSON data, do
//
//     final graphMonthParentResponse = graphMonthParentResponseFromJson(jsonString);

import 'dart:convert';

GraphMonthParentResponse graphMonthParentResponseFromJson(String str) => GraphMonthParentResponse.fromJson(json.decode(str));

String graphMonthParentResponseToJson(GraphMonthParentResponse data) => json.encode(data.toJson());

class GraphMonthParentResponse {
  GraphMonthParentResponse({
    required this.status,
    required this.data,
  });

  int status;
  List<GraphMonthResponse> data;

  factory GraphMonthParentResponse.fromJson(Map<String, dynamic> json) => GraphMonthParentResponse(
    status: json["status"],
    data: List<GraphMonthResponse>.from(json["data"].map((x) => GraphMonthResponse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GraphMonthResponse {
  GraphMonthResponse({
    this.timeStamp,
    this.serial,
    this.totalYield,
    this.dayYield,
    this.dateI,
    this.timeI,
    this.dayHour,
    this.powerMax,
  });

  dynamic timeStamp;
  String? serial;
  dynamic totalYield;
  dynamic dayYield;
  String? dateI;
  TimeI? timeI;
  dynamic dayHour;
  String? powerMax;

  factory GraphMonthResponse.fromJson(Map<String, dynamic> json) => GraphMonthResponse(
    timeStamp: json["TimeStamp"],
    serial: json["Serial"],
    totalYield: json["TotalYield"],
    dayYield: json["DayYield"],
    dateI: json["DateI"],
    timeI: timeIValues.map?[json["TimeI"]],
    dayHour: json["DayHour"],
    powerMax: json["PowerMax"] == null ? null : json["PowerMax"],
  );

  Map<String, dynamic> toJson() => {
    "TimeStamp": timeStamp,
    "Serial": serial,
    "TotalYield": totalYield,
    "DayYield": dayYield,
    "DateI": dateI,
    "TimeI": timeIValues.reverse?[timeI],
    "DayHour": dayHour,
    "PowerMax": powerMax == null ? null : powerMax,
  };
}

enum TimeI { THE_0000 }

final timeIValues = EnumValues({
  "00:00": TimeI.THE_0000
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
