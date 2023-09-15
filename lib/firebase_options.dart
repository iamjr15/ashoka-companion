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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEi_HB6eNIhNTXDVYmYJ5wYjgaYXRLqXc',
    appId: '1:929335192361:android:3bdbcc796a793c57442538',
    messagingSenderId: '929335192361',
    projectId: 'ashokacompanion',
    storageBucket: 'ashokacompanion.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1a9jbGqLyTT4XThFqfDOMEDJANfG3Ufo',
    appId: '1:929335192361:ios:b06d5441cbee9d89442538',
    messagingSenderId: '929335192361',
    projectId: 'ashokacompanion',
    storageBucket: 'ashokacompanion.appspot.com',
    androidClientId: '929335192361-e11n4anni02krfk8jo1e0ta8b3pj5vl5.apps.googleusercontent.com',
    iosClientId: '929335192361-5omt8el6jduquvs8h0b3dtq9rgohu7sm.apps.googleusercontent.com',
    iosBundleId: 'com.ashokacompanion.jigyansurout',
  );
}
