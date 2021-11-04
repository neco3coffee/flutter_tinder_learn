import 'package:get/get.dart';
import 'auth.dart';

class GoogleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GoogleController>(GoogleController());
  }
}
