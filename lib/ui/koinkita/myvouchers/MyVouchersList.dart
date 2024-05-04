import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:solar_kita/data/dummy.dart';
import 'package:solar_kita/model/BannerModel.dart';
import 'package:solar_kita/network/model/response/voucher_response.dart';
import 'package:solar_kita/res/my_button.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/koinkita/detailvouchers/DetailVoucherScreen.dart';
import 'package:solar_kita/ui/koinkita/widget/VoucherCard.dart';
import 'package:solar_kita/ui/profile/profile.dart';
import 'package:solar_kita/utils/tools.dart';

class MyVouchersList extends StatefulWidget {

  bool isRedeedm;
  String title;
  VoucherResponse voucherResponse;
  String koin;
  bool isFromRedeem;

  MyVouchersList({required this.title, required this.voucherResponse, required this.koin, this.isFromRedeem = false, this.isRedeedm = false});

  @override
  _MyVouchersListState createState() => _MyVouchersListState();
}

class _MyVouchersListState extends State<MyVouchersList> {
  late Size size;

  List<Widget> _buildVouchers(){
    List<Widget> vs = [];
    for(int i=0; i < (widget.voucherResponse.data?.length ?? 0); i++){
      vs.add(VoucherCardWidget(isRedeem: widget.isRedeedm,voucher: widget.voucherResponse.data![i],koin: widget.koin,onSuccess: (){},));
      vs.add(SizedBox(height: 10,));
    }
    return vs;
  }

  @override
  void initState() {
    super.initState();
    if(widget.isFromRedeem){
      SchedulerBinding.instance.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Berhasil Redeem Voucher'),
            content: Text('Silahkan pilih voucher anda'),
          )
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: MyColors.accentDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        actions: [
          // InkWell(
          //   onTap: (){
          //     Tools.addScreen(context, ProfileScreen());
          //   },
          //   child: CircleAvatar(
          //     backgroundColor: MyColors.accentDark,
          //     child: Icon(Icons.person_outline),
          //   ),
          // ),
          SizedBox(
            width: 20,
          )
        ],
        title: MyText.myTextHeader2(widget.title != null ? widget.title : "My Vouchers", MyColors.accentDark),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: MyColors.white,
        child: ListView(
          children: [
            Row(children: [
              Spacer(),
              Image.asset('assets/coins.png',width: 20,),
              SizedBox(width: 5,),
              MyText.myTextDescription(widget.koin.toString(), MyColors.grey_60),
            ],),
            SizedBox(height: 20,),
            Column(
              children: _buildVouchers(),
            )
          ],
        ),
      ),
    );
  }
  
}
