import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';

abstract class SystemProfileState extends Equatable {}

class SystemProfileLoaded extends SystemProfileState {
  final SystemProfileResponse items;
  SystemProfileLoaded({required this.items});
  @override
  List<Object> get props => [items];
}

class SystemProfileDetailLoaded extends SystemProfileState {
  final SystemProfileResponse items;
  SystemProfileDetailLoaded({required this.items});
  @override
  List<Object> get props => [items];
}

class SystemProfileError extends SystemProfileState {
  final String message;
  SystemProfileError({required this.message});
  @override
  List<Object> get props => [message];
}
