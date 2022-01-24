import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_kita/prefmanager/pref_data.dart';
import 'package:solar_kita/res/my_colors.dart';
import 'package:solar_kita/ui/dashboard.dart';
import 'package:solar_kita/ui/notification/notification_model.dart';
import 'package:solar_kita/ui/splashscreen.dart';
import 'firebase_options.dart';
import 'package:sqflite/sqflite.dart';



Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future<List<NotificationModel>> _getNotifs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var prefd = prefs.getStringList(PrefData.NOTIF,);
    if(prefd == null){
      return [];
    }else{
      var notifList = prefd.map((e) => NotificationModel.fromJson(jsonDecode(e))).toList();
      return notifList;
    }
  }

  Future<void> saveNotif(List<NotificationModel> models) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("gilang3");
    var mapped = models.map((e) => jsonEncode(e.toJson())).toList();
    prefs.setStringList(PrefData.NOTIF, mapped);
  }

  @override
  Widget build(BuildContext context) {

    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("468a677d-445c-4964-bc54-115796dc1848");


    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      print("gilang1");
      var current = _getNotifs();
      current.then((value) {
        print("gilang2 : " + value.length.toString());
        value.add(NotificationModel(1, event.notification.title,
            event.notification.body, event.notification.additionalData["url"],
          event.notification.additionalData["image"]));
        saveNotif(value);
      });

      event.complete(event.notification);
    });

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {

    });


// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: MyColors.primary, accentColor: MyColors.accentDark),
      home: SplashScreen(),
    );
  }
}

