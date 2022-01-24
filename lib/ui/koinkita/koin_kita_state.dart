import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/graph_day_response.dart';
import 'package:solar_kita/network/model/response/graph_month_response.dart';
import 'package:solar_kita/network/model/response/graph_total_response.dart';
import 'package:solar_kita/network/model/response/graph_year_response.dart';
import 'package:solar_kita/network/model/response/koin_response.dart';
import 'package:solar_kita/network/model/response/login_response.dart';
import 'package:solar_kita/network/model/response/response_redeem.dart';
import 'package:solar_kita/network/model/response/system_profile_response.dart';
import 'package:solar_kita/network/model/response/voucher_banner_response.dart';
import 'package:solar_kita/network/model/response/voucher_categories.dart';
import 'package:solar_kita/network/model/response/voucher_response.dart';

abstract class KoinKitaState extends Equatable {}


class InitialState extends KoinKitaState {
  InitialState();
  @override
  List<Object> get props => null;
}

class LoadingState extends KoinKitaState {
  LoadingState();
  @override
  List<Object> get props => null;
}


class LoadedState extends KoinKitaState {
  final KoinResponse items;
  LoadedState({@required this.items});
  @override
  List<Object> get props => [items];
}

class VoucherLoadedState extends KoinKitaState {
  final VoucherResponse items;
  VoucherLoadedState({@required this.items});
  @override
  List<Object> get props => [items];
}

class MyVoucherLoadedState extends KoinKitaState {
  final VoucherResponse items;
  MyVoucherLoadedState({@required this.items});
  @override
  List<Object> get props => [items];
}

class MyVoucherCategoriesDetailLoadedState extends KoinKitaState {
  final VoucherResponse items;
  final String title;
  MyVoucherCategoriesDetailLoadedState({@required this.items,@required this.title});
  @override
  List<Object> get props => [items];
}

class RedemSuccess extends KoinKitaState {
  ResponseRedeem responseRedeem;

  RedemSuccess(this.responseRedeem);

  @override
  List<Object> get props => [];
}

class VoucherBannerLoadedState extends KoinKitaState {
  final VoucherBannerResponse items;
  VoucherBannerLoadedState({@required this.items});
  @override
  List<Object> get props => [items];
}

class VoucherCategoriesLoadedState extends KoinKitaState {
  final VoucherCategoriesResponse items;
  VoucherCategoriesLoadedState({@required this.items});
  @override
  List<Object> get props => [items];
}

class ErrorState extends KoinKitaState {
  final String message;
  ErrorState({@required this.message});
  @override
  List<Object> get props => [message];
}
