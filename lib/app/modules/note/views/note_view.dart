import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/note_controller.dart';

class NoteView extends GetView<NoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoteView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NoteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomSheet: getBottomSheet(),
    );
  }

  Widget getBottomSheet() {
    return Container(
      width: 500,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Get.toNamed('/note');
              },
              icon: Icon(
                Icons.note_alt_outlined,
                color: Colors.pink,
                size: 42,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed('/home');
              },
              icon: Icon(
                Icons.play_circle_filled,
                color: Colors.pink,
                size: 42,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed('/stack');
              },
              icon: Icon(
                Icons.file_copy_outlined,
                color: Colors.pink,
                size: 42,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
