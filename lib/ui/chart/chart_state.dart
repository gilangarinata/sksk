import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';

abstract class ChartState extends Equatable {}

class ChartDailyLoaded extends ChartState {
  final List<GraphDayResponse> items;
  ChartDailyLoaded({required this.items});
  @override
  List<Object> get props => [items];
}

class ChartMonthlyLoaded extends ChartState {
  final List<GraphMonthResponse> items;
  ChartMonthlyLoaded({required this.items});
  @override
  List<Object> get props => [items];
}

class ChartYearlyLoaded extends ChartState {
  final List<GraphYearResponse> items;
  ChartYearlyLoaded({required this.items});
  @override
  List<Object> get props => [items];
}

class ChartTotalLoaded extends ChartState {
  final List<GraphTotalResponse> items;
  ChartTotalLoaded({required this.items});
  @override
  List<Object> get props => [items];
}

class InitialState extends ChartState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ChartState {
  @override
  List<Object> get props => [];
}

class DeleteLoadingState extends ChartState {
  @override
  List<Object> get props => [];
}

class ErrorState extends ChartState {
  final String message;
  ErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
