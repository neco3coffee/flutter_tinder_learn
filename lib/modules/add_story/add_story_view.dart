import 'package:flutter/material.dart';
import 'package:flutter_tinder_learn/modules/home/home.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'add_story.dart';

class AddStoryView extends GetView<AddStoryController> {
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddStoryView'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.image,
              ),
              iconSize: 90,
              color: Colors.lightGreen.shade400,
              splashColor: Colors.lightGreen.shade100,
              onPressed: () {
                controller.getImage(ImageSource.gallery);
                homeController.shown.value = false;
                homeController.box.write('shownx', homeController.shown.value);
              },
            ),
            SizedBox(
              width: 30,
            ),
            IconButton(
              icon: Icon(
                Icons.camera_alt,
              ),
              iconSize: 90,
              color: Colors.lightGreen.shade400,
              splashColor: Colors.lightGreen.shade100,
              onPressed: () {
                controller.getImage(ImageSource.camera);
                homeController.shown.value = false;
                homeController.box.write('shownx', homeController.shown.value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
