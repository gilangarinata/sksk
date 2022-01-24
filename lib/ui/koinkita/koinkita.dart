import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_kita/data/dummy.dart';
import 'package:solar_kita/model/BannerModel.dart';
import 'package:solar_kita/network/model/response/voucher_banner_response.dart';
import 'package:solar_kita/network/model/response/voucher_categories.dart';
import 'package:solar_kita/network/model/response/voucher_response.dart';
import 'package:solar_kita/network/repository/koinkita_repository.dart';
import 'package:solar_kita/res/my_button.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/koinkita/koin_kita_bloc.dart';
import 'package:solar_kita/ui/koinkita/koin_kita_state.dart';
import 'package:solar_kita/ui/koinkita/myvouchers/MyVouchersList.dart';
import 'package:solar_kita/ui/koinkita/widget/VoucherCard.dart';
import 'package:solar_kita/utils/tools.dart';
import 'package:solar_kita/widget/my_snackbar.dart';
import 'package:solar_kita/widget/progress_loading.dart';
import 'package:url_launcher/url_launcher.dart';

import 'koin_kita_event.dart';

class KoinKitaScreen  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KoinKitaBloc>(
          create: (context) => KoinKitaBloc(KoinKitaRepositoryImpl()),
        ),
      ],
      child: KoinKitaScreenChild(),
    );
  }
}


class KoinKitaScreenChild extends StatefulWidget {
  @override
  _KoinKitaScreenState createState() => _KoinKitaScreenState();
}

class _KoinKitaScreenState extends State<KoinKitaScreenChild> {
  Size size;
  PageController pageController = PageController(
    initialPage: 0,
  );
  int page = 0;
  bool isLast = false;
  String textNext = "Next";

  String koin = "";
  bool _isLoading = false;
  VoucherResponse _voucherResponse;
  VoucherResponse _myVoucherResponse;
  VoucherCategoriesResponse _voucherCategoriesResponse;
  VoucherBannerResponse _voucherBannerResponse;
  KoinKitaBloc bloc;

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  void initState() {
    super.initState();
    bloc = context.read<KoinKitaBloc>();
    bloc.add(GetKoin());
    bloc.add(GetVouchers());
    bloc.add(GetVoucherCategories());
    bloc.add(GetVoucherBanner());
    bloc.add(GetMyVouchers());
  }

  List<Widget> getHorizontalCategories(){
    List<Widget> listView = [];
    if(_voucherCategoriesResponse != null){
      for(int i = 0; i < _voucherCategoriesResponse.data.length; i ++){
        var item = _voucherCategoriesResponse.data[i];
        listView.add(
          InkWell(
            onTap: (){
              bloc.add(GetVouchersCategoriesDetail(item.id.toString(),item.name));
            },
            child: Container(
              width: (size.width / 2.5) - 10,
              height: (size.width / 2.5) - 10,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: MyColors.primary,width: 2)
              ),
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(item.icon, width: 80,height: 80,fit: BoxFit.cover,),
                  SizedBox(height: 10,),
                  MyText.myTextDescription(item.name, MyColors.accentDark)
                ],
              )),
            ),
          ),
        );
      }
    }
    return listView;
  }

  List<Widget> _buildVouchers(){
    List<Widget> vs = [];
    if(_voucherResponse != null){
      for(int i=0; i < _voucherResponse.data.length; i++){
        vs.add(VoucherCardWidget(isRedeem: true,voucher: _voucherResponse.data[i],koin: "",onSuccess: (value){
          if(value == 201) {
            setState(() {
              _isLoading = true;
            });
            Timer(Duration(seconds: 5), () {
              Tools.addScreen(context, MyVouchersList(
                voucherResponse: _myVoucherResponse, koin: koin, isFromRedeem : true));
            });
            bloc.add(GetMyVouchers());
            bloc.add(GetVouchers());
          }
        },));
        vs.add(SizedBox(height: 10,));
      }
    }
    return vs;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BlocListener<KoinKitaBloc, KoinKitaState>(
      listener: (context, state) async {
        if (state is ErrorState) {
          setState(() {
            _isLoading = false;
            MySnackbar.errorSnackbar(context, state.message);
          });
        } else if(state is LoadingState){
          setState(() {
            _isLoading = true;
          });
        } else if (state is LoadedState) {
          setState(() {
            _isLoading = false;
            koin = state.items.data.availableKoin;
          });
        }else if(state is VoucherLoadedState){
          setState(() {
            _isLoading = false;
            _voucherResponse = state.items;
            print("get voucher success : "+ _voucherResponse.data[0].image);
          });
        }else if(state is MyVoucherCategoriesDetailLoadedState){
          setState(() {
            _isLoading = false;
          });
          Tools.addScreen(context, MyVouchersList(title: state.title,voucherResponse: state.items,koin: koin,isRedeedm : true));
        } else if(state is VoucherCategoriesLoadedState){
          setState(() {
            _voucherCategoriesResponse = state.items;
          });
        }else if(state is VoucherBannerLoadedState){
          setState(() {
            _voucherBannerResponse = state.items;
          });
        }else if(state is MyVoucherLoadedState){
          setState(() {
            _isLoading = false;
            _myVoucherResponse = state.items;
          });
        }
      },
      child: _isLoading ? ProgressLoading() : Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: MyColors.white,
        child: ListView(
          children: [
            Row(children: [
              Container(
                width: size.width / 3,
                child: MyButton.myBorderButton(MyStrings.myVouchers, 5,  (){
                  if(_myVoucherResponse != null){
                    Tools.addScreen(context, MyVouchersList(voucherResponse: _myVoucherResponse, koin: koin,));
                  }
                }),
              ),
              Spacer(),
              Image.asset('assets/coins.png',width: 20,),
              SizedBox(width: 5,),
              MyText.myTextDescription(koin, MyColors.grey_60),
            ],),
            SizedBox(height: 20,),
            Container(
              width: size.width,
              height: 150,
              child: PageView(
                controller: pageController,
                children: buildPageViewItem(),
                onPageChanged:(index) {
                  setState(() {
                    page = index;
                  });
                },
              ),
            ),
            Container(
              height: 30,
              child: Align(
                alignment: Alignment.center,
                child: buildDots(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: MyText.myTextHeader2(MyStrings.merchantCategory, MyColors.accentDark),
            ),
            Container(
              height: (size.width / 2.5) + 20,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getHorizontalCategories()
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.myTextHeader2(MyStrings.newVouchers, MyColors.accentDark),
                  SizedBox(height: 10,),
                  Column(
                    children: _buildVouchers(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildPageViewItem(){
    List<Widget> widgets = [];
    if(_voucherBannerResponse != null) {
      for(int i = 0; i < _voucherBannerResponse.data.length; i ++){
        var item = _voucherBannerResponse.data[i];
        Widget wg = Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: InkWell(
            onTap: (){
              String aStr = item.redirect_url.replaceAll(new RegExp(r'[^0-9]'),''); // '23'
              if(aStr.isNotEmpty){
                int categoryId = int.tryParse(aStr);
                if(categoryId != null){
                  var categoryName = "";
                  _voucherCategoriesResponse.data.forEach((element) {
                    if(element.id == categoryId){
                      categoryName = element.name;
                    }
                  });
                  bloc.add(GetVouchersCategoriesDetail(categoryId.toString(),categoryName));
                }
              }
            },
            child: Container(
              width: double.infinity,
              height: 150,
              child: Image.network(item.image, fit: BoxFit.fill,),
            ),
          ),
        );
        widgets.add(wg);
      }
    }
    return widgets;
  }

  Widget buildDots(BuildContext context){
    int bannerLength = 0;

    if(_voucherBannerResponse != null){
      bannerLength = _voucherBannerResponse.data.length;
    }


    Widget widget;

    List<Widget> dots = [];
    for(int i=0; i<bannerLength; i++){
      Widget w = Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 5,
        width: 16,
        child: Container(
          color: page == i ? MyColors.accentDark : MyColors.grey_20,
        ),
      );
      dots.add(w);
    }
    widget = Row(
      mainAxisSize: MainAxisSize.min,
      children: dots,
    );
    return widget;
  }
}
