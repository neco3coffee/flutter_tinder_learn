import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth.dart';

class GoogleView extends GetView<GoogleController> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.yellowAccent),
        ),
        // child: Text('pending'),
      ),
    );
  }
}
