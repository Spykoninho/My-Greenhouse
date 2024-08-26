// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  static final String android_api_key =
      dotenv.env['FIREBASE_API_ANDROID_KEY'] ?? '';

  static FirebaseOptions android = FirebaseOptions(
    apiKey: android_api_key,
    appId: '1:191964483764:android:5c4629f212aedd308b07e1',
    messagingSenderId: '191964483764',
    projectId: 'my-greenhouse-155fb',
    storageBucket: 'my-greenhouse-155fb.appspot.com',
  );

  static final String ios_api_key = dotenv.env['FIREBASE_API_IOS_KEY'] ?? '';

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: ios_api_key,
    appId: '1:191964483764:ios:555a5d2dc01a3d7b8b07e1',
    messagingSenderId: '191964483764',
    projectId: 'my-greenhouse-155fb',
    storageBucket: 'my-greenhouse-155fb.appspot.com',
    iosBundleId: 'com.mygreenhouse.mobileApp',
  );
}
