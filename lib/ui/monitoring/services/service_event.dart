import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';

abstract class ServiceEvent extends Equatable {}

class FetchService extends ServiceEvent {
  String type;
  String message;
  int helpTypeId;
  String date;
  String time;

  FetchService(this.type, this.message, this.helpTypeId, this.date, this.time);

  @override
  List<Object> get props => null;
}

class FetchHelpCenterList extends ServiceEvent {

  @override
  List<Object> get props => null;

  FetchHelpCenterList();
}


class FetchMaintenanceList extends ServiceEvent {

  @override
  List<Object> get props => null;

  FetchMaintenanceList();
}

class FetchNotificationList extends ServiceEvent {

  @override
  List<Object> get props => null;

  FetchNotificationList();
}

