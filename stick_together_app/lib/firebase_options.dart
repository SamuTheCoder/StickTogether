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
    apiKey: 'AIzaSyDTeeRs6RYwOvYcECy5PgsHPUGZ5oMVvAA',
    appId: '1:499418815884:web:29524c49e78c7568dd8aa9',
    messagingSenderId: '499418815884',
    projectId: 'stick-together-ed715',
    authDomain: 'stick-together-ed715.firebaseapp.com',
    storageBucket: 'stick-together-ed715.appspot.com',
    measurementId: 'G-3LLVBXHX0D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBr3CcZGr6wd7stVAkdNHlOT_kyQXDRsHc',
    appId: '1:499418815884:android:5ebde409c53ce3b3dd8aa9',
    messagingSenderId: '499418815884',
    projectId: 'stick-together-ed715',
    storageBucket: 'stick-together-ed715.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_MKuOEbvo-5up7sNNhAxuFmwbsWiRp0c',
    appId: '1:499418815884:ios:567dca223f03733add8aa9',
    messagingSenderId: '499418815884',
    projectId: 'stick-together-ed715',
    storageBucket: 'stick-together-ed715.appspot.com',
    iosClientId: '499418815884-gt8r6o02pmfq363gs6m69c3t2tqgevn2.apps.googleusercontent.com',
    iosBundleId: 'com.example.stickTogetherApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_MKuOEbvo-5up7sNNhAxuFmwbsWiRp0c',
    appId: '1:499418815884:ios:567dca223f03733add8aa9',
    messagingSenderId: '499418815884',
    projectId: 'stick-together-ed715',
    storageBucket: 'stick-together-ed715.appspot.com',
    iosClientId: '499418815884-gt8r6o02pmfq363gs6m69c3t2tqgevn2.apps.googleusercontent.com',
    iosBundleId: 'com.example.stickTogetherApp',
  );
}
