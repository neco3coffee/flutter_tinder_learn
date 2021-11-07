import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tinder_learn/routes/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../api/api.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool shown = false.obs;
  final box = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    // box.write('shownx', false);
    if (box.read('shownx') != null) {
      shown.value = box.read('shownx');
    }
    print("🔥home controller onInit ${box.read('shownx')}");
    await NotificationApi.init(initScheduled: true);
    listenNotifications();

    NotificationApi.scheduleDailyTenAMNotification();

    // NotificationApi.showScheduledNotification(
    //   title: '👀story',
    //   body: '今日のストーリーをチャチャっと復習しましょう',
    //   payload: 'story',
    //   scheduledDate: DateTime.now().add(const Duration(seconds: 3)),
    // );
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Get.toNamed(Routes.STORY);

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    box.write('shownx', shown.value);
  }
}
