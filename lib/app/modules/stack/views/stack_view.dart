import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/stack_controller.dart';

class StackView extends GetView<StackController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StackView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StackView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
