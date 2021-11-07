import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

import 'home.dart';
import '../../shared/shared.dart';
import '../../api/api.dart';
// import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

// import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as image;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text('👀instantLearn✌️'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.ADDSTORY);
                        },
                        child: Container(
                          width: 65,
                          height: 65,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            '${controller.auth.currentUser!.photoURL}'),
                                        fit: BoxFit.cover)),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 19,
                                    height: 19,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Colors.pink,
                                      size: 19,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 65,
                        height: 65,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/instantLearn.png'),
                                      fit: BoxFit.cover)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 65,
                        height: 65,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/instantLearn.png'),
                                      fit: BoxFit.cover)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 65,
                        height: 65,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/instantLearn.png'),
                                      fit: BoxFit.cover)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 65,
                        height: 65,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/instantLearn.png'),
                                      fit: BoxFit.cover)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 65,
                        height: 65,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/instantLearn.png'),
                                      fit: BoxFit.cover)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Obx(
            () => UnicornOutlineButton(
              strokeWidth: 4,
              radius: 100,
              gradient:
                  // controller.box.read('shownx')
                  homeController.shown.value
                      ? const LinearGradient(
                          colors: [Colors.white, Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      : const LinearGradient(
                          colors: [Colors.blue, Colors.yellow],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
              child: Text('''
            
     👀     
            ''', style: TextStyle(fontSize: 70, height: 1)),
              onPressed: () {
                Get.toNamed(Routes.STORY);
              },
            ),
          ),
          // ElevatedButton(
          //   child: const Text('Button'),
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.orange,
          //     onPrimary: Colors.white,
          //   ),
          //   onPressed: () {
          //     NotificationApi.showNotification(
          //       title: '👀story',
          //       body: '今日のストーリーをチャチャっと復習しましょう',
          //       payload: 'sarah.abs',
          //     );
          //   },
          // ),
          ElevatedButton(
            child: const Text('Button'),
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              NotificationApi.scheduleDailyTenAMNotification();
            },
          ),
        ],
      ),
    );
  }
}
