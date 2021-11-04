import 'package:get/get.dart';
import 'account.dart';
import '../add_story/add_story.dart';
import '../home/home.dart';
import '../auth/auth.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AccountController>(AccountController());
    Get.put<AddStoryController>(AddStoryController());
    Get.put<HomeController>(HomeController());
    Get.lazyPut<GoogleController>(() => GoogleController());
  }
}
