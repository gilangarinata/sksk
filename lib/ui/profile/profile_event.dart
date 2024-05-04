import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';

abstract class ProfileEvent extends Equatable {}

class FetchProfile extends ProfileEvent {



  FetchProfile();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SaveProfile extends ProfileEvent {
  String name;
  String company;



  SaveProfile(this.name, this.company);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ChangePassword extends ProfileEvent {
  String oldPassword;
  String newPassword;
  String newPassword2;



  ChangePassword(this.oldPassword, this.newPassword, this.newPassword2);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}