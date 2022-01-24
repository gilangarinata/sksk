import 'package:equatable/equatable.dart';

abstract class KoinKitaEvent extends Equatable {}

class GetKoin extends KoinKitaEvent {
  @override
  List<Object> get props => null;
  GetKoin();
}

class GetVouchers extends KoinKitaEvent {
  @override
  List<Object> get props => null;
  GetVouchers();
}

class GetVouchersCategoriesDetail extends KoinKitaEvent {

  String categoryId;
  String title;

  @override
  List<Object> get props => null;

  GetVouchersCategoriesDetail(this.categoryId,this.title);
}

class GetMyVouchers extends KoinKitaEvent {
  @override
  List<Object> get props => null;
  GetMyVouchers();
}

class RedeemVoucher extends KoinKitaEvent {
  String id;

  RedeemVoucher(this.id);

  @override
  List<Object> get props => null;
}

class GetVoucherBanner extends KoinKitaEvent {
  @override
  List<Object> get props => null;
  GetVoucherBanner();
}

class GetVoucherCategories extends KoinKitaEvent {
  @override
  List<Object> get props => null;
  GetVoucherCategories();
}