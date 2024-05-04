// To parse this JSON data, do
//
//     final systemProfileResponse = systemProfileResponseFromJson(jsonString);

import 'dart:convert';

SystemProfileResponse systemProfileResponseFromJson(String str) => SystemProfileResponse.fromJson(json.decode(str));

String systemProfileResponseToJson(SystemProfileResponse data) => json.encode(data.toJson());

class SystemProfileResponse {
  SystemProfileResponse({
    this.status,
    this.data,
  });

  int? status;
  Data? data;

  factory SystemProfileResponse.fromJson(Map<String, dynamic> json) => SystemProfileResponse(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.todayProduction,
    this.monthlyEnergy,
    this.totalEnergy,
    this.totalSaving,
    this.monthlySaving,
    this.co2Reduced,
    this.solarSystems,
    this.solarSystemProfile
  });

  String? todayProduction;
  String? monthlyEnergy;
  String? totalEnergy;
  String? totalSaving;
  String? monthlySaving;
  String? co2Reduced;
  List<SolarSystem>? solarSystems;
  List<SolarSystemProfle>? solarSystemProfile;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    todayProduction: json["today_production"],
    monthlyEnergy: json["monthly_energy"],
    totalEnergy: json["total_energy"],
    totalSaving: json["total_saving"],
    monthlySaving: json["monthly_saving"],
    co2Reduced: json["co2_reduced"],
    solarSystems: json["solar_systems"] == null ? null :  List<SolarSystem>.from(json["solar_systems"].map((x) => SolarSystem.fromJson(x))),
    solarSystemProfile: json["solar_system_profle"] == null ? null :  List<SolarSystemProfle>.from(json["solar_system_profle"].map((x) => SolarSystemProfle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "today_production": todayProduction,
    "monthly_energy": monthlyEnergy,
    "total_energy": totalEnergy,
    "total_saving": totalSaving,
    "monthly_saving": monthlySaving,
    "co2_reduced": co2Reduced,
    "solar_systems": List<dynamic>.from(solarSystems!.map((x) => x.toJson())),
    "solar_system_profle": List<dynamic>.from(solarSystemProfile!.map((x) => x.toJson())),
  };
}

class SolarSystem {
  SolarSystem({
    this.invId,
    this.pvSysPower,
    this.location,
  });

  String? invId;
  String? pvSysPower;
  String? location;

  factory SolarSystem.fromJson(Map<String, dynamic> json) => SolarSystem(
    invId: json["inv_id"],
    pvSysPower: json["pv_sys_power"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "inv_id": invId,
    "pv_sys_power": pvSysPower,
    "location": location,
  };
}


class SolarSystemProfle {
  SolarSystemProfle({
    this.pvSysPower,
    this.commisioning,
    this.location,
    this.modules,
    this.inverter,
    this.solarSystemProfleOperator,
    this.communication,
  });

  String? pvSysPower;
  String? commisioning;
  String? location;
  String? modules;
  String? inverter;
  String? solarSystemProfleOperator;
  String? communication;

  factory SolarSystemProfle.fromJson(Map<String, dynamic> json) => SolarSystemProfle(
    pvSysPower: json["pv_sys_power"],
    commisioning: json["commisioning"],
    location: json["location"],
    modules: json["modules"],
    inverter: json["inverter"],
    solarSystemProfleOperator: json["operator"],
    communication: json["communication"],
  );

  Map<String, dynamic> toJson() => {
    "pv_sys_power": pvSysPower,
    "commisioning": commisioning,
    "location": location,
    "modules": modules,
    "inverter": inverter,
    "operator": solarSystemProfleOperator,
    "communication": communication,
  };
}
