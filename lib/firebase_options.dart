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
    apiKey: 'AIzaSyDDUyu9PwLSpJbuKSDEXfCHqJhOJJAipcM',
    appId: '1:908293276083:web:ac640faced36f1dc05cbc6',
    messagingSenderId: '908293276083',
    projectId: 'we-care-97c21',
    authDomain: 'we-care-97c21.firebaseapp.com',
    storageBucket: 'we-care-97c21.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDs4Y3GbRmO0uVKlBq_Gd9FbfPwJNWOhQI',
    appId: '1:908293276083:android:a648b75d1279989105cbc6',
    messagingSenderId: '908293276083',
    projectId: 'we-care-97c21',
    storageBucket: 'we-care-97c21.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjMoZjpKinjmgrEJBhDlFknmHPdVX3LW4',
    appId: '1:908293276083:ios:b30eee5248831fe905cbc6',
    messagingSenderId: '908293276083',
    projectId: 'we-care-97c21',
    storageBucket: 'we-care-97c21.appspot.com',
    iosBundleId: 'com.example.weCare',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjMoZjpKinjmgrEJBhDlFknmHPdVX3LW4',
    appId: '1:908293276083:ios:4f3317e5eb9e694305cbc6',
    messagingSenderId: '908293276083',
    projectId: 'we-care-97c21',
    storageBucket: 'we-care-97c21.appspot.com',
    iosBundleId: 'com.example.weCare.RunnerTests',
  );
}
