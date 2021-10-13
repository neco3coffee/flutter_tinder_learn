import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_controller.dart';

class NewView extends GetView<NewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NewView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
