import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import './routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('app_icon');
  // final InitializationSettings initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  // );
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String? payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: $payload');
  //   }
  //   // selectedNotificationPayload = payload;
  //   // selectNotificationSubject.add(payload);
  // });
  runApp(GetMaterialApp(
    initialRoute: AppPages.INITIAL,
    defaultTransition: Transition.native,
    theme: ThemeData(
        primaryColor: Colors.lightGreen.shade200,
        appBarTheme: AppBarTheme(color: Colors.lightGreen.shade200)),
    getPages: AppPages.routes,
  ));
}
