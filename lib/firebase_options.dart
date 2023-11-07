// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA_aLsiwnh3CJZicOxfykl1adhbiGj1kO4',
    appId: '1:737104043054:web:a69f4e0bf3af55355153bf',
    messagingSenderId: '737104043054',
    projectId: 'game-ui-6c24f',
    authDomain: 'game-ui-6c24f.firebaseapp.com',
    storageBucket: 'game-ui-6c24f.appspot.com',
    measurementId: 'G-NZ9P2VGNL4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0lWhk5QEVre9Hh4hFGJzL0M4alK2sR1Q',
    appId: '1:737104043054:android:2581d57f186f7b5b5153bf',
    messagingSenderId: '737104043054',
    projectId: 'game-ui-6c24f',
    storageBucket: 'game-ui-6c24f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCeD5hv17uyGuXeK6GiB3rbplI8_iBAIFU',
    appId: '1:737104043054:ios:7edaabee64e586d45153bf',
    messagingSenderId: '737104043054',
    projectId: 'game-ui-6c24f',
    storageBucket: 'game-ui-6c24f.appspot.com',
    iosBundleId: 'com.example.simplegame',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCeD5hv17uyGuXeK6GiB3rbplI8_iBAIFU',
    appId: '1:737104043054:ios:449802c8dbdb454b5153bf',
    messagingSenderId: '737104043054',
    projectId: 'game-ui-6c24f',
    storageBucket: 'game-ui-6c24f.appspot.com',
    iosBundleId: 'com.example.simplegame.RunnerTests',
  );
}
