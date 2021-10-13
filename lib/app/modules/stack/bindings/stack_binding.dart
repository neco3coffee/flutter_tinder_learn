import 'package:get/get.dart';

import '../controllers/stack_controller.dart';

class StackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StackController>(
      () => StackController(),
    );
  }
}
