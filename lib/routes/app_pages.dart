import 'package:firebase_auth/firebase_auth.dart';

import '../modules/home/home.dart';
import '../modules/add_story/add_story.dart';
import '../modules/account/account.dart';
import '../modules/auth/auth.dart';
import '../modules/root/root.dart';
import '../modules/show_story/show_story.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.GOOGLEAUTH;
  late FirebaseAuth auth = FirebaseAuth.instance;

  static final routes = [
    GetPage(
      name: Routes.GOOGLEAUTH,
      page: () => GoogleView(),
      binding: GoogleBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.ROOT,
      page: () => RootPage(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: Routes.ADDSTORY,
      page: () => AddStoryView(),
      binding: AddStoryBinding(),
    ),
    GetPage(
      name: Routes.STORY,
      page: () => MoreStories(),
      binding: AccountBinding(),
    ),
  ];
}
