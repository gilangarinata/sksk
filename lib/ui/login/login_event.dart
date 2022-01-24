import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';

abstract class LoginEvent extends Equatable {}

class ProcessLogin extends LoginEvent {
  String username;
  String password;
  @override
  List<Object> get props => null;
  ProcessLogin(this.username, this.password);
}
