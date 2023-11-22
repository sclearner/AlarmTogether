import 'package:alarmtogether/controllers/firebase_helper/authentication.dart';
import 'package:alarmtogether/controllers/local_helper/notification.dart';

import 'package:alarmtogether/views/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'controllers/routes/app_routes_controller.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppRoutesHelper.instance;
  Authentication.instance.authStateChanges().listen((user) {
    if (user == null) {
      print("Sign out");
    }
    else {
      print(user);
    }
  });
  if (Authentication.user == null) await Authentication.instance.signInAnonymously();
  Workmanager().initialize(LocalNotificationHelper.callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask("noti", "alarmTogetherNoti");
  runApp(const MyApp());
}

