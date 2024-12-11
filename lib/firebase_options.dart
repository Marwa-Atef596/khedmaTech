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
    apiKey: 'AIzaSyDuWyazmuWzAhiMYDokeVBy2wy69EuNrIA',
    appId: '1:481628165739:web:594fdebf41e018e9a9032e',
    messagingSenderId: '481628165739',
    projectId: 'khedma-teck',
    authDomain: 'khedma-teck.firebaseapp.com',
    storageBucket: 'khedma-teck.appspot.com',
    measurementId: 'G-G64L4JKF2D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAj6iW7nWZScU9GiN6rrnV1jBqPsC0-7_k',
    appId: '1:481628165739:android:6773bca61e66b888a9032e',
    messagingSenderId: '481628165739',
    projectId: 'khedma-teck',
    storageBucket: 'khedma-teck.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAH0UR3XRT4jbYAwiPI1thFyV_zIcrYXQ4',
    appId: '1:481628165739:ios:7a396b417f87d5f6a9032e',
    messagingSenderId: '481628165739',
    projectId: 'khedma-teck',
    storageBucket: 'khedma-teck.appspot.com',
    iosBundleId: 'com.example.khedmaTech',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAH0UR3XRT4jbYAwiPI1thFyV_zIcrYXQ4',
    appId: '1:481628165739:ios:70cf90a994410707a9032e',
    messagingSenderId: '481628165739',
    projectId: 'khedma-teck',
    storageBucket: 'khedma-teck.appspot.com',
    iosBundleId: 'com.example.khedmaTech.RunnerTests',
  );
}