import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';

abstract class ChartEvent extends Equatable {}

class FetchDailyGraph extends ChartEvent {
  @override
  List<Object> get props => null;
  final String date;
  final String inverterId;
  FetchDailyGraph(this.date,this.inverterId);
}

class FetchMonthlyGraph extends ChartEvent {
  @override
  List<Object> get props => null;
  final String month;
  final String inverterId;
  FetchMonthlyGraph(this.month, this.inverterId);
}

class FetchYearlyGraph extends ChartEvent {
  @override
  List<Object> get props => null;
  final String year;
  final String inverterId;
  FetchYearlyGraph(this.year,this.inverterId);
}

class FetchTotalGraph extends ChartEvent {
  final String inverterId;
  @override
  List<Object> get props => null;
  FetchTotalGraph(this.inverterId);
}
