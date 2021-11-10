import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class FirebaseMessagingHelper {
  static final _fbm = FirebaseMessaging.instance;
  static BuildContext? _context;
  static void configure(BuildContext context) {
    _context = context;
    _fbm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      dynamic notification = message.data;
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      dynamic notification = message.data;
      print(message);
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      dynamic notification = message.data;
      print(message);
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print("FirebaseMessaging.getInitialMessage");
    });
  }

  static Future<void> getToken() async {
    String? token = await _fbm.getToken(
      vapidKey:
          "BMqVNDTFAvV3zqO9Lp8_oDsoHO04JkR05LYsH6Vg15_FwBlDLsTRfogk9BHnJnK5jsipxY10JEe0_BfUMTs0i4c",
    );
    print("Push Messaging token: $token");
    final prefs = await SharedPreferences.getInstance();
    if (token != null) prefs.setString(Constant.prefsUserFBTokenKey, token);
  }
}
