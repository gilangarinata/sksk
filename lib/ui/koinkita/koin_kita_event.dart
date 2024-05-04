import 'package:equatable/equatable.dart';

abstract class KoinKitaEvent extends Equatable {}

class GetKoin extends KoinKitaEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  GetKoin();
}

class GetVouchers extends KoinKitaEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  GetVouchers();
}

class GetVouchersCategoriesDetail extends KoinKitaEvent {

  String categoryId;
  String title;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  GetVouchersCategoriesDetail(this.categoryId,this.title);
}

class GetMyVouchers extends KoinKitaEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  GetMyVouchers();
}

class RedeemVoucher extends KoinKitaEvent {
  String id;

  RedeemVoucher(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetVoucherBanner extends KoinKitaEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  GetVoucherBanner();
}

class GetVoucherCategories extends KoinKitaEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  GetVoucherCategories();
}