import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'HomeView is working yo',
            style: TextStyle(fontSize: 20),
          ),
        ),
        bottomSheet: getBottomSheet()
        // AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   title: Padding(
        //     padding: const EdgeInsets.all(10),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         IconButton(
        //           onPressed: () {
        //             Get.toNamed('/note');
        //           },
        //           icon: Icon(
        //             Icons.note_alt_outlined,
        //             color: Colors.pink,
        //             size: 42,
        //             semanticLabel: 'Text to announce in accessibility modes',
        //           ),
        //         ),
        //         IconButton(
        //           onPressed: () {
        //             Get.toNamed('/note');
        //           },
        //           icon: Icon(
        //             Icons.play_circle_filled,
        //             color: Colors.pink,
        //             size: 42,
        //             semanticLabel: 'Text to announce in accessibility modes',
        //           ),
        //         ),
        //         IconButton(
        //           onPressed: () {
        //             Get.toNamed('/note');
        //           },
        //           icon: Icon(
        //             Icons.file_copy_outlined,
        //             color: Colors.pink,
        //             size: 42,
        //             semanticLabel: 'Text to announce in accessibility modes',
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
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

// comment for issue commits
