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
    apiKey: 'AIzaSyDXJ12BNwxzY84AY7KW4-8DKHQF3kUsKFg',
    appId: '1:757704925626:web:342444c2248035ac45bd83',
    messagingSenderId: '757704925626',
    projectId: 'ca13-4d1d1',
    authDomain: 'ca13-4d1d1.firebaseapp.com',
    storageBucket: 'ca13-4d1d1.firebasestorage.app',
    measurementId: 'G-0DSMPNKN60',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApEvJ9fUek18fGbRCqEPvFVQKRQvLHvUI',
    appId: '1:757704925626:android:1bac5bf4853177d445bd83',
    messagingSenderId: '757704925626',
    projectId: 'ca13-4d1d1',
    storageBucket: 'ca13-4d1d1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7i2lOvcxWn90ooPj1KdrnFXbfP8KCcAc',
    appId: '1:757704925626:ios:acc289b82771479645bd83',
    messagingSenderId: '757704925626',
    projectId: 'ca13-4d1d1',
    storageBucket: 'ca13-4d1d1.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD7i2lOvcxWn90ooPj1KdrnFXbfP8KCcAc',
    appId: '1:757704925626:ios:acc289b82771479645bd83',
    messagingSenderId: '757704925626',
    projectId: 'ca13-4d1d1',
    storageBucket: 'ca13-4d1d1.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDXJ12BNwxzY84AY7KW4-8DKHQF3kUsKFg',
    appId: '1:757704925626:web:b74e6e4ef381f68645bd83',
    messagingSenderId: '757704925626',
    projectId: 'ca13-4d1d1',
    authDomain: 'ca13-4d1d1.firebaseapp.com',
    storageBucket: 'ca13-4d1d1.firebasestorage.app',
    measurementId: 'G-Z37G8B6LG4',
  );
}
