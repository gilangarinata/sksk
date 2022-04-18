import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';

abstract class ProfileEvent extends Equatable {}

class FetchProfile extends ProfileEvent {

  @override
  List<Object> get props => null;

  FetchProfile();
}

class SaveProfile extends ProfileEvent {
  String name;
  String company;

  @override
  List<Object> get props => null;

  SaveProfile(this.name, this.company);
}

class ChangePassword extends ProfileEvent {
  String oldPassword;
  String newPassword;
  String newPassword2;

  @override
  List<Object> get props => null;

  ChangePassword(this.oldPassword, this.newPassword, this.newPassword2);
}