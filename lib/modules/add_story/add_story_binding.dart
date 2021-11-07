import 'package:flutter_tinder_learn/modules/home/home.dart';
import 'package:get/get.dart';

import 'add_story.dart';

class AddStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddStoryController>(AddStoryController());
    Get.put<HomeController>(HomeController());
  }
}
