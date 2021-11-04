import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'add_story.dart';

class AddStoryView extends GetView<AddStoryController> {
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
