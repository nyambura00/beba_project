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
    apiKey: 'AIzaSyC9u5ScbDuX3i5QsPQnr4_E7r60COTGy7U',
    appId: '1:655688320588:web:83949e2904bbb0332ed6e9',
    messagingSenderId: '655688320588',
    projectId: 'beba-73d47',
    authDomain: 'beba-73d47.firebaseapp.com',
    storageBucket: 'beba-73d47.appspot.com',
    measurementId: 'G-G6LF93LZHR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAn1SZ8s65XhnD3YIWVqwGrlofdxqlHO0s',
    appId: '1:655688320588:android:30637e19a83461512ed6e9',
    messagingSenderId: '655688320588',
    projectId: 'beba-73d47',
    storageBucket: 'beba-73d47.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlUIFGxrPEBMCk1b39F2yjfEL2l4njP0k',
    appId: '1:655688320588:ios:a814e16a9ee616972ed6e9',
    messagingSenderId: '655688320588',
    projectId: 'beba-73d47',
    storageBucket: 'beba-73d47.appspot.com',
    androidClientId: '655688320588-40pcqldbfnmepf0uegduu4vikpjr01j8.apps.googleusercontent.com',
    iosClientId: '655688320588-gtg8ohn8sc7v5eim9cvbgtjudjgc1k4k.apps.googleusercontent.com',
    iosBundleId: 'com.example.bebaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBlUIFGxrPEBMCk1b39F2yjfEL2l4njP0k',
    appId: '1:655688320588:ios:a814e16a9ee616972ed6e9',
    messagingSenderId: '655688320588',
    projectId: 'beba-73d47',
    storageBucket: 'beba-73d47.appspot.com',
    androidClientId: '655688320588-40pcqldbfnmepf0uegduu4vikpjr01j8.apps.googleusercontent.com',
    iosClientId: '655688320588-gtg8ohn8sc7v5eim9cvbgtjudjgc1k4k.apps.googleusercontent.com',
    iosBundleId: 'com.example.bebaApp',
  );
}
