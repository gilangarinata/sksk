import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/network/model/response/voucher_response.dart';
import 'package:solar_kita/network/repository/koinkita_repository.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/res/my_strings.dart';
import 'package:solar_kita/res/my_text.dart';
import 'package:solar_kita/ui/koinkita/koin_kita_event.dart';
import 'package:solar_kita/ui/koinkita/widget/VoucherCard.dart';
import 'package:solar_kita/widget/my_snackbar.dart';
import 'package:solar_kita/widget/progress_loading.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as Io;
import '../koin_kita_bloc.dart';
import '../koin_kita_state.dart';

class DetailVoucherScreen extends StatelessWidget {
  bool isRedeem;
  Datum data;

  DetailVoucherScreen(this.isRedeem, this.data);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KoinKitaBloc>(
          create: (context) => KoinKitaBloc(KoinKitaRepositoryImpl()),
        ),
      ],
      child: DetailVoucherScreenContent(isRedeem, data),
    );
  }
}

class DetailVoucherScreenContent extends StatefulWidget {
  bool isRedeem;
  Datum data;

  DetailVoucherScreenContent(this.isRedeem, this.data);

  @override
  _DetailVoucherScreenState createState() => _DetailVoucherScreenState();
}

class _DetailVoucherScreenState extends State<DetailVoucherScreenContent> {
  Size size;
  KoinKitaBloc bloc;
  bool _isLoading = false;
  String _localPath;

  bool downloading = true;
  String downloadingStr = "No data";
  String savePath = "";

  @override
  void initState() {
    super.initState();
    bloc = context.read<KoinKitaBloc>();
  }

  Future<String> _getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return "Bearer " + prefs.getString(PrefData.TOKEN);
  }

  Future<void> openFile(String filename) async {
    print(filename);
    await OpenFile.open(filename);
  }

  Future downloadFile(String url, String fileName) async {
    try {
      setState(() {
        _isLoading = true;
      });

      var token = await _getToken();

      Dio dio = Dio();
      dio.options.headers =
      {'Authorization': token};

      savePath = await getFilePath(fileName);
      print("savePath: " + savePath + token);
      print("url: " + url);
      await dio.download(url,
          savePath,
          onReceiveProgress: (rec, total) {
        setState(() {
          _isLoading = false;
        });
        openFile(savePath);
      } );
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }

  /*
  void downloadFile(String downloadUrl, String filename) async {
    await FlutterDownloader.enqueue(
      url: downloadUrl,
      savedDir: _localPath,
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
  }

  void initDownloader() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
    );
  }

  Future<void> _prepareSaveDir() async {
    _localPath =
        (await _findLocalPath()) + Io.Platform.pathSeparator + 'koinkita-vouchers';
    print("localPath" + _localPath);
    final savedDir = Io.Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String> _findLocalPath() async {
    final directory = await getExternalStorageDirectory();
    return directory?.path;
  }
*/
  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: MyColors.accentDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: MyText.myTextHeader2("Detail Voucher", MyColors.accentDark),
      ),
      body: BlocListener<KoinKitaBloc, KoinKitaState>(
        listener: (context, state) async {
          if (state is ErrorState) {
            setState(() {
              _isLoading = false;
              MySnackbar.errorSnackbar(context, state.message);
            });
          } else if (state is LoadingState) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is RedemSuccess) {
            setState(() {
              _isLoading = false;
            });
            if (state.responseRedeem.status == 200) {
              MySnackbar.successSnackbar(context, "Redeem Success");
              Navigator.pop(context,201);
            } else {
              MySnackbar.errorSnackbar(context, state.responseRedeem.message);
            }
          }
        },
        child: Container(
          color: MyColors.white,
          child: ListView(
            children: [
            VoucherCardWidget(isRedeem: null,voucher: widget.data,koin: ""),
              SizedBox(height: 10,),
              Container(height: 10, color: MyColors.grey_5,),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.myTextHeader2("Detail Produk", MyColors.accentDark),
                    SizedBox(height: 10,),
                    Html(
                        data: widget.data.description == null ? "" : widget.data
                            .description)
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(height: 10, color: MyColors.grey_5,),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.myTextHeader2(
                        "Syarat dan Ketentuan", MyColors.accentDark),
                    SizedBox(height: 10,),
                    Html(data: widget.data.syarat == null ? "" : widget.data
                        .syarat)
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(height: 10, color: MyColors.grey_5,),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.myTextHeader2("Cara Pakai", MyColors.accentDark),
                    SizedBox(height: 10,),
                    Html(data: widget.data.caraRedeem == null ? "" : widget.data
                        .caraRedeem,)
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          bool isDemo = prefs.getBool(PrefData.IS_DEMO);

          if(isDemo){
            MySnackbar.showToast("Not Available. You are using demo account.");
            return;
          }


          if (widget.isRedeem) {
            if (widget.data != null) {
              bloc.add(RedeemVoucher(widget.data.id.toString()));
            }
          } else {
            if (widget.data != null) {
              downloadFile("https://apps.solarkita.com/my-vouchers/"+widget.data.id.toString(), DateTime
                  .now()
                  .timeZoneOffset
                  .inMilliseconds
                  .toString() + "-Voucher.pdf");
            }
          }
        },
        child: Container(
          width: double.infinity,
          height: 50,
          color: widget.isRedeem ? MyColors.primary : MyColors.accentDark,
          child: Center(
              child: _isLoading
                  ? ProgressLoading()
                  : MyText.myTextHeader2(
                  widget.isRedeem
                      ? MyStrings.redeemVoucher
                      : MyStrings.downloadVoucher,
                  widget.isRedeem
                      ? MyColors.accentDark
                      : MyColors.primary)),
        ),
      ),
    );
  }
}
