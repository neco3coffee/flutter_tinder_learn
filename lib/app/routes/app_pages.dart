import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_tinder_learn/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_tinder_learn/app/modules/home/views/home_view.dart';
import 'package:flutter_tinder_learn/app/modules/note/bindings/note_binding.dart';
import 'package:flutter_tinder_learn/app/modules/note/new/bindings/new_binding.dart';
import 'package:flutter_tinder_learn/app/modules/note/new/views/new_view.dart';
import 'package:flutter_tinder_learn/app/modules/note/views/note_view.dart';
import 'package:flutter_tinder_learn/app/modules/stack/bindings/stack_binding.dart';
import 'package:flutter_tinder_learn/app/modules/stack/views/stack_view.dart';

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
      children: [
        GetPage(
          name: _Paths.NEW,
          page: () => NewView(),
          binding: NewBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.STACK,
      page: () => StackView(),
      binding: StackBinding(),
    ),
  ];
}
