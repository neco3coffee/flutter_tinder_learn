import 'package:get/get.dart';

import '../controllers/new_controller.dart';

class NewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewController>(
      () => NewController(),
    );
  }
}
