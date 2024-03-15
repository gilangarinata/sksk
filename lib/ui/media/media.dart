import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solar_kita/widget/progress_loading.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MediaScreen extends StatefulWidget {
  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  Size size;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Stack(
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
          initialUrl: 'https://www.solarkita.com/blog',
        ),
        Align(
          alignment: Alignment.center,
          child: Visibility(
              visible: isLoading,
              child: ProgressLoading()),
        ),
      ],
    );
  }

}
