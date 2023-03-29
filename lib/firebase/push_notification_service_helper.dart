import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class pushNotificationService {
  FirebaseMessaging fcm;
  Future initialize(context) async {
    await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print('++++++++++++hese is firebase message');
      print(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('++++++++++++hese is firebase message');
      print(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('++++++++++++hese is firebase message');
      print(message);
    });
    FirebaseMessaging.onBackgroundMessage((message) {
      print('++++++++++++hese is firebase message');
      print(message);
      return _firebaseMessagingBackgroundHandler(message, context);
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message, context) async {
    print('++++++++++++hese is firebase message');
    print(message);
  }

  Future<void> getToken() async {
    String token = await FirebaseMessaging.instance.getToken();
    print('token:$token');
    // DatabaseReference tokenRef = FirebaseDatabase.instance
    //     .reference()
    //     .child('drivers/${currentFirebaseUser!.uid}/token');
    // tokenRef.set(token);
    // FirebaseMessaging.instance.subscribeToTopic('allDrivers');
    // FirebaseMessaging.instance.subscribeToTopic('allUsers');

    // return token!;
  }
}
