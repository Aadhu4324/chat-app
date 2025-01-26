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
    apiKey: 'AIzaSyDtEb-0spGcXpiqzuzlkSEkRakSAg3Y8zs',
    appId: '1:813113499358:web:6fb7ad1dd192ebed852c4f',
    messagingSenderId: '813113499358',
    projectId: 'chat-app3-7bcb6',
    authDomain: 'chat-app3-7bcb6.firebaseapp.com',
    storageBucket: 'chat-app3-7bcb6.firebasestorage.app',
    measurementId: 'G-SBX37ZQDN7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1MEutbXyBfeNg6peiF5HVvoLfzHMhjbg',
    appId: '1:813113499358:android:636bb57e4a5f99f1852c4f',
    messagingSenderId: '813113499358',
    projectId: 'chat-app3-7bcb6',
    storageBucket: 'chat-app3-7bcb6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1LidZC_o5RHUSMyZK5_8WEZMHjLmYji4',
    appId: '1:813113499358:ios:4acced6ddb665e13852c4f',
    messagingSenderId: '813113499358',
    projectId: 'chat-app3-7bcb6',
    storageBucket: 'chat-app3-7bcb6.firebasestorage.app',
    iosBundleId: 'com.example.chatApplication3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1LidZC_o5RHUSMyZK5_8WEZMHjLmYji4',
    appId: '1:813113499358:ios:4acced6ddb665e13852c4f',
    messagingSenderId: '813113499358',
    projectId: 'chat-app3-7bcb6',
    storageBucket: 'chat-app3-7bcb6.firebasestorage.app',
    iosBundleId: 'com.example.chatApplication3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDtEb-0spGcXpiqzuzlkSEkRakSAg3Y8zs',
    appId: '1:813113499358:web:e78ae703b35ea6bb852c4f',
    messagingSenderId: '813113499358',
    projectId: 'chat-app3-7bcb6',
    authDomain: 'chat-app3-7bcb6.firebaseapp.com',
    storageBucket: 'chat-app3-7bcb6.firebasestorage.app',
    measurementId: 'G-WY73T6R632',
  );
}
