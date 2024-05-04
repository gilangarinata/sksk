import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:solar_kita/res/my_button.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_field_style.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/koinkita/koinkita.dart';
import 'package:solar_kita/ui/monitoring/Monitoring.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  var faqTitle = "Kontibusi apa yang dapat diberkan secara langsung?";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: MyText.myTextHeader2(MyStrings.faq, MyColors.accentDark),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: "Bagaimana cara saya melihat performa sistem PLTS Atap?",
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: "Seluruh data produksi PLTS Anda dapat dilihat di halaman Monitoring System Mobile Apps kami.",
                  ),
                ),
              ), collapsed: SizedBox(),
            ),
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: "Bagaimana cara saya melihat penghematan yang telah saya dapatkan?",
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: "Penghematan yang Anda dapatkan terdapat di halaman monitoring system di bagian  “Monthly Saving” dan “Total Saving”.",
                  ),
                ),
              ), collapsed: SizedBox(),
            ),
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: "Bagaimana cara saya melakukan claim voucher KoinKita?",
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: "Untuk melakukan claim voucher KoinKita, silahkan sentuh (tap) icon “K” yang terdapat pada bagian bawah layar gadget Anda. Silahkan pilih voucher KoinKita berdasarkan kategori yang tersedia.",
                  ),
                ),
              ), collapsed: SizedBox(),
            ),
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: "Bagaimana cara saya melihat voucher yang sudah berhasil saya claim?",
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: "Voucher dapat dilihat pada halaman “My Voucher” dan juga dikirim ke email Anda.",
                  ),
                ),
              ), collapsed: SizedBox(),
            ),
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: "Bagaimana cara saya melakukan perubahan data profile?",
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: "Sentuh (tap) icon di bagian kanan atas layar gadget Anda. Sentuh (tap) “Update Profile”. Silahkan simpan data baru Anda dengan cara sentuh (tap) tombol “save” pada bagian bawah.",
                  ),
                ),
              ), collapsed: SizedBox(),
            ),
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: "Bagaimana cara saya merubah password?",
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: "Silahkan sentuh (tap) icon di bagian kanan atas layar gadget Anda. Sentuh (tap) “Change Password”. Silahkan simpan password baru Anda dengan cara sentuh (tap) tombol “save” pada bagian bawah.",
                  ),
                ),
              ), collapsed: SizedBox(),
            ),
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: "Bagaimana cara saya mengajukan permintaan maintenance?",
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: "Sentuh (tap) “Services” yang terdapat pada bagian atas di halaman “Monitoring System”. Silahkan pilih “Maintenance Request” pada kolom jenis layanan yang Anda butuhkan,  tentukan jadwal maintenance yang Anda inginkan. Terakhir, silahkan sentuh (tap) tombol “Submit”. Tim Maintenance SolarKita akan segera menghubungi Anda dalam waktu paling lambat 3 x 24 jam.",
                  ),
                ),
              ), collapsed: SizedBox(),
            ),
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: "Bagaimana cara menghubungi Customer Service SolarKita?",
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: "Silahkan sentuh (tap) button “Free Consult” pada bagian kanan bawah layar gadget Anda. Anda akan langsung terhubung ke Whatsapp official SolarKita. Silahkan sampaikan pertanyaan Anda dan kami aku selalu siap membantu Anda.",
                  ),
                ),
              ), collapsed: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
