import 'package:flutter/material.dart';
import 'package:solar_kita/network/model/response/voucher_response.dart';
import 'package:solar_kita/res/my_button.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/koinkita/detailvouchers/DetailVoucherScreen.dart';
import 'package:solar_kita/utils/tools.dart';

class VoucherCardWidget extends StatelessWidget {
  bool? isRedeem;
  Datum? voucher;
  String koin;
  Function? onSuccess;

  VoucherCardWidget({required this.isRedeem, required this.voucher, required this.koin, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailVoucherScreen(isRedeem!, voucher),
          ),
        ).then((value) {
          onSuccess!(value);
        });
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: MyColors.white,
        child: Container(
          width: double.infinity,
          height: 170,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(voucher?.image ?? "",height: 170,width: 170,fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Container(
                      width: 170,
                      height: 170,
                      child: Center(child: Text('No Image')),
                    );
                  },
                ),
                // child: Image.asset('assets/voucher.png'),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: TextStyle(
                              color: MyColors.accentDark, fontSize: 20.0, fontWeight: FontWeight.bold),
                          text: voucher?.name,
                        ),
                      ),
                      SizedBox(height: 5,),
                      MyText.myTextDescription2(voucher?.merchantType ?? "", MyColors.grey_60),
                      SizedBox(height: 5,),
                      MyText.myTextHeader3(voucher?.koin.toString() ?? "" + " Koin Kita", MyColors.accentDark),
                      SizedBox(height: 5,),
                      Visibility(
                        visible: isRedeem != null,
                        child:
                      MyButton.myBorderTransparentButton(MyStrings.seeDetails, 13, (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailVoucherScreen(isRedeem ?? false, voucher),
                          ),
                        ).then((value) => onSuccess!(201));
                      }),
                      )

                    ],
                  ),
                ),
              ),
              Container(
                width: 10,
                color: MyColors.accentDark,
              )
            ],
          ),
        ),
      ),
    );
  }
}
