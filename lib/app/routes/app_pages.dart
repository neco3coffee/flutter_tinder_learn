import 'package:get/get.dart';

import 'package:flutter_tinder_learn/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_tinder_learn/app/modules/home/views/home_view.dart';
import 'package:flutter_tinder_learn/app/modules/note/bindings/note_binding.dart';
import 'package:flutter_tinder_learn/app/modules/note/views/note_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NOTE,
      page: () => NoteView(),
      binding: NoteBinding(),
    ),
  ];
}
