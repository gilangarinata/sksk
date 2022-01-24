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
                  text: faqTitle,
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: MyStrings.loremLong,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: faqTitle,
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: MyStrings.loremLong,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: faqTitle,
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: MyStrings.loremLong,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: faqTitle,
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: MyStrings.loremLong,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ExpandablePanel(
              header: RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: MyColors.accentDark, fontSize: 19.0, fontWeight: FontWeight.normal),
                  text: faqTitle,
                ),
              ),
              // collapsed: Text(article.body, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
              expanded: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: MyColors.grey_80, fontSize: 14.0, fontWeight: FontWeight.normal),
                    text: MyStrings.loremLong,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
