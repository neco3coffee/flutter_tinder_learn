import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import './routes/app_pages.dart';

// model

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    initialRoute: AppPages.INITIAL,
    defaultTransition: Transition.native,
    theme: ThemeData(
        primaryColor: Colors.lightGreen.shade200,
        appBarTheme: AppBarTheme(color: Colors.lightGreen.shade200)),
    getPages: AppPages.routes,
  ));
}
