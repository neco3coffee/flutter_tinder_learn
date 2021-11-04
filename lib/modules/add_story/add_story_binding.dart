import 'package:get/get.dart';

import 'add_story.dart';

class AddStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddStoryController>(AddStoryController());
  }
}
