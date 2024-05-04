import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';

abstract class ChartEvent extends Equatable {}

class FetchDailyGraph extends ChartEvent {

  final String date;
  final String inverterId;
  FetchDailyGraph(this.date,this.inverterId);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchMonthlyGraph extends ChartEvent {

  final String month;
  final String inverterId;
  FetchMonthlyGraph(this.month, this.inverterId);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchYearlyGraph extends ChartEvent {

  final String year;
  final String inverterId;
  FetchYearlyGraph(this.year,this.inverterId);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchTotalGraph extends ChartEvent {
  final String inverterId;

  FetchTotalGraph(this.inverterId);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
