import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/help_center_list_response.dart';
import 'package:solar_kita/network/model/response/maintenance_list_response.dart';
import 'package:solar_kita/network/model/response/notification_response.dart';
import 'package:solar_kita/network/model/response/profile_response.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';

abstract class ProfileState extends Equatable {}

class InitialState extends ProfileState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class SaveSuccess extends ProfileState {
  SaveSuccess();
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileState {
  final ProfileResponse items;
  ProfileLoaded({@required this.items});
  @override
  List<Object> get props => [items];
}

class ServiceError extends ProfileState {
  final String message;
  ServiceError({@required this.message});
  @override
  List<Object> get props => [message];
}

