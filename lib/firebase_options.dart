// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB_sj5y4KNhkzujphPumDfX3MWVPyEPYLE',
    appId: '1:682801886067:web:c0c14a569e8ab4db340b06',
    messagingSenderId: '682801886067',
    projectId: 'arosaje-424508',
    authDomain: 'arosaje-424508.firebaseapp.com',
    storageBucket: 'arosaje-424508.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAx5qNk60xuS2YnV65XGRK1IeP3Z3l_yKU',
    appId: '1:682801886067:android:3f2c8337bfd06e4d340b06',
    messagingSenderId: '682801886067',
    projectId: 'arosaje-424508',
    storageBucket: 'arosaje-424508.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPOZLzCiocO02WC6_d3GWsT-ttjb-MO88',
    appId: '1:682801886067:ios:4712a4784aec3757340b06',
    messagingSenderId: '682801886067',
    projectId: 'arosaje-424508',
    storageBucket: 'arosaje-424508.appspot.com',
    iosBundleId: 'com.epsi.arosaje',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPOZLzCiocO02WC6_d3GWsT-ttjb-MO88',
    appId: '1:682801886067:ios:4712a4784aec3757340b06',
    messagingSenderId: '682801886067',
    projectId: 'arosaje-424508',
    storageBucket: 'arosaje-424508.appspot.com',
    iosBundleId: 'com.epsi.arosaje',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB_sj5y4KNhkzujphPumDfX3MWVPyEPYLE',
    appId: '1:682801886067:web:44764f08034d71a6340b06',
    messagingSenderId: '682801886067',
    projectId: 'arosaje-424508',
    authDomain: 'arosaje-424508.firebaseapp.com',
    storageBucket: 'arosaje-424508.appspot.com',
  );

}