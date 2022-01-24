import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';

abstract class SystemProfileEvent extends Equatable {}

class FetchSystemProfile extends SystemProfileEvent {
  @override
  List<Object> get props => null;
  FetchSystemProfile();
}

class FetchSystemProfileDetail extends SystemProfileEvent {
  String id;
  @override
  List<Object> get props => null;
  FetchSystemProfileDetail(this.id);
}



