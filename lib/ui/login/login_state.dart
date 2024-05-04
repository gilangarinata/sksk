import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';
import 'package:solar_kita/network/model/response/login_response.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';


abstract class LoginState extends Equatable {}

class LoginSuccess extends LoginState {
  final LoginResponse items;
  LoginSuccess({required this.items});
  @override
  List<Object> get props => [items];
}

class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
  @override
  List<Object> get props => [message];
}

class InitialState extends LoginState {
  InitialState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoadingState extends LoginState {
  LoadingState();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
