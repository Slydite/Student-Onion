// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSygTrIAabRjDoZJBHe3eZhhOWBFN1sbc',
    appId: '1:338211521114:android:cd454cbe47c024d4290e63',
    messagingSenderId: '338211521114',
    projectId: 'student-onion',
    storageBucket: 'student-onion.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0E4d8SHeb5OdE5W4Qhk1eIVbKIUMNg3s',
    appId: '1:338211521114:ios:4d928b3aefc92279290e63',
    messagingSenderId: '338211521114',
    projectId: 'student-onion',
    storageBucket: 'student-onion.appspot.com',
    iosClientId: '338211521114-hcr4olkuo4td69s6raa6nq8cr50t3843.apps.googleusercontent.com',
    iosBundleId: 'com.slydite.studentonion',
  );
}
