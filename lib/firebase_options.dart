// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDeeb2tNFimYdFRezM5nOI3Te3waUuWVyQ',
    appId: '1:301834280291:web:f3ca7dc3406eec9bf68756',
    messagingSenderId: '301834280291',
    projectId: 'solarkita-app',
    authDomain: 'solarkita-app.firebaseapp.com',
    storageBucket: 'solarkita-app.appspot.com',
    measurementId: 'G-4RTKLKJZGB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEL-sBXQYuIq7jB4n4d-pkg5SfOIZem28',
    appId: '1:301834280291:android:662670f1d0f45599f68756',
    messagingSenderId: '301834280291',
    projectId: 'solarkita-app',
    storageBucket: 'solarkita-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3XOIIckkTzXgQhwILuXz4i6r8Gd7iiXs',
    appId: '1:301834280291:ios:542388823e2bdaaff68756',
    messagingSenderId: '301834280291',
    projectId: 'solarkita-app',
    storageBucket: 'solarkita-app.appspot.com',
    iosClientId: '301834280291-46h4m6b4l2getgqrvchj8ucl8q2vvnb8.apps.googleusercontent.com',
    iosBundleId: 'com.solarkita.app-ios',
  );
}
