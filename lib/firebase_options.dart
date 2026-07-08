
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
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
    apiKey: 'AIzaSyBRjaQsZtaS1bYolKwko1lqWYPCxJRVLQY',
    appId: '1:684192153883:web:a6eaf2532ac611082153be',
    messagingSenderId: '684192153883',
    projectId: 'notes-app-3ff41',
    authDomain: 'notes-app-3ff41.firebaseapp.com',
    storageBucket: 'notes-app-3ff41.firebasestorage.app',
    measurementId: 'G-YVLZ6ZBL9M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBaeinYLZLR6bU-mFhWBk_ZXWTs4bnbBa8',
    appId: '1:684192153883:android:0ee9d71347af44592153be',
    messagingSenderId: '684192153883',
    projectId: 'notes-app-3ff41',
    storageBucket: 'notes-app-3ff41.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6TWxb6NSEXwOXeYZqe_N0INaR9PqQ7rg',
    appId: '1:684192153883:ios:06983e86db21f57b2153be',
    messagingSenderId: '684192153883',
    projectId: 'notes-app-3ff41',
    storageBucket: 'notes-app-3ff41.firebasestorage.app',
    iosBundleId: 'com.example.notesApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6TWxb6NSEXwOXeYZqe_N0INaR9PqQ7rg',
    appId: '1:684192153883:ios:06983e86db21f57b2153be',
    messagingSenderId: '684192153883',
    projectId: 'notes-app-3ff41',
    storageBucket: 'notes-app-3ff41.firebasestorage.app',
    iosBundleId: 'com.example.notesApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBRjaQsZtaS1bYolKwko1lqWYPCxJRVLQY',
    appId: '1:684192153883:web:60481afd55964f642153be',
    messagingSenderId: '684192153883',
    projectId: 'notes-app-3ff41',
    authDomain: 'notes-app-3ff41.firebaseapp.com',
    storageBucket: 'notes-app-3ff41.firebasestorage.app',
    measurementId: 'G-YTH584KKSK',
  );
}
