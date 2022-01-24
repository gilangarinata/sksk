import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/help_center_list_response.dart';
import 'package:solar_kita/network/model/response/maintenance_list_response.dart';
import 'package:solar_kita/network/model/response/notification_response.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';

abstract class ServiceState extends Equatable {}

class InitialState extends ServiceState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ServiceState {
  @override
  List<Object> get props => [];
}

class ServiceLoaded extends ServiceState {
  final bool items;
  ServiceLoaded({@required this.items});
  @override
  List<Object> get props => [items];
}

class ServiceError extends ServiceState {
  final String message;
  ServiceError({@required this.message});
  @override
  List<Object> get props => [message];
}

class MaintenanceListLoaded extends ServiceState {
  final MaintenanceListResponse items;
  MaintenanceListLoaded({@required this.items});
  @override
  List<Object> get props => [items];
}

class HelpCenterListLoaded extends ServiceState {
  final HelpCenterListResponse items;
  HelpCenterListLoaded({@required this.items});
  @override
  List<Object> get props => [items];
}

class NotificationListLoaded extends ServiceState {
  final NotificationResponse items;
  NotificationListLoaded({@required this.items});
  @override
  List<Object> get props => [items];
}
