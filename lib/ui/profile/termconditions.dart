import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solar_kita/widget/progress_loading.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermAndConditionScreen extends StatefulWidget {
  @override
  _TermAndConditionScreenState createState() => _TermAndConditionScreenState();
}

class _TermAndConditionScreenState extends State<TermAndConditionScreen> {
  Size? size;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          WebView(
            onProgress: (pr){
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (pr){
              setState(() {
                isLoading = false;
              });
            },
            initialUrl: 'https://solarkita.com/term-and-condition',
          ),
          Align(
            alignment: Alignment.center,
            child: Visibility(
                visible: isLoading,
                child: ProgressLoading()),
          ),
        ],
      ),
    );
  }

}
