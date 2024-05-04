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
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}

class FetchHelpCenterList extends ServiceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  FetchHelpCenterList();
}


class FetchMaintenanceList extends ServiceEvent {

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  FetchMaintenanceList();
}

class FetchNotificationList extends ServiceEvent {

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  FetchNotificationList();
}

