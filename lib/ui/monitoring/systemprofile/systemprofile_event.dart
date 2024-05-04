import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';

abstract class SystemProfileEvent extends Equatable {}

class FetchSystemProfile extends SystemProfileEvent {

  FetchSystemProfile();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchSystemProfileDetail extends SystemProfileEvent {
  String id;
  String month;
  String year;

  FetchSystemProfileDetail(this.id,this.month,this.year);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}



