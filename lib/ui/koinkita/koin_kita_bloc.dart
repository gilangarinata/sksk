import 'package:bloc/bloc.dart';
import 'package:solar_kita/network/model/response/koin_response.dart';
import 'package:solar_kita/network/model/response/response_redeem.dart';
import 'package:solar_kita/network/model/response/voucher_banner_response.dart';
import 'package:solar_kita/network/model/response/voucher_categories.dart';
import 'package:solar_kita/network/model/response/voucher_response.dart';
import 'package:solar_kita/network/repository/koinkita_repository.dart';
import 'package:solar_kita/ui/koinkita/koin_kita_event.dart';
import 'package:solar_kita/ui/koinkita/koin_kita_state.dart';

class KoinKitaBloc extends Bloc<KoinKitaEvent, KoinKitaState?> {
  KoinKitaRepository repository;

  KoinKitaBloc(this.repository) : super(null);

  @override
  KoinKitaState get initialState => InitialState();

  @override
  Stream<KoinKitaState> mapEventToState(KoinKitaEvent event) async* {
    if (event is GetKoin) {
      try {
        yield LoadingState();
        KoinResponse items = await repository.fetchKoin();
        print("login sukses");
        yield LoadedState(items: items);
      } catch (e) {
        print("get koin error");
        yield ErrorState(message: e.toString());
      }
    } else if (event is GetVouchers) {
      try {
        yield LoadingState();
        VoucherResponse items = await repository.fetchVouchers();
        print("get voucher success");
        yield VoucherLoadedState(items: items);
      } catch (e) {
        print("get viucher error");
        yield ErrorState(message: e.toString());
      }
    } else if (event is GetVoucherBanner) {
      try {
        yield LoadingState();
        VoucherBannerResponse items = await repository.fetchVoucherBanner();
        print("GetVoucherBanner sukses");
        yield VoucherBannerLoadedState(items: items);
      } catch (e) {
        print("get voucher banner error");
        yield ErrorState(message: e.toString());
      }
    } else if (event is GetVoucherCategories) {
      try {
        yield LoadingState();
        VoucherCategoriesResponse items = await repository.fetchVoucherCategories();
        print("login sukses");
        yield VoucherCategoriesLoadedState(items: items);
      } catch (e) {
        print("get voucher category error");
        yield ErrorState(message: e.toString());
      }
    } else if (event is GetMyVouchers) {
      try {
        yield LoadingState();
        VoucherResponse items = await repository.fetchMyVouchers();
        print("get voucher success");
        yield MyVoucherLoadedState(items: items);
      } catch (e) {
        print("get my voucher error");
        yield ErrorState(message: e.toString());
      }
    }else if (event is RedeemVoucher) {
      try {
        yield LoadingState();
        ResponseRedeem items = await repository.postRedeem(event.id);
        yield RedemSuccess(items);
      } catch (e) {
        print("redeem error");
        yield ErrorState(message: e.toString());
      }
    }else if (event is GetVouchersCategoriesDetail) {
      try {
        yield LoadingState();
        VoucherResponse items = await repository.fetchVoucherCategoriesDetail(event.categoryId);
        yield MyVoucherCategoriesDetailLoadedState(items: items, title: event.title);
      } catch (e) {
        print("get voucher cat detail error error");
        yield ErrorState(message: e.toString());
      }
    }
  }
}
