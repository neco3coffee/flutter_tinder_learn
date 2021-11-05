import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AddStoryController extends GetxController {
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // Crop code
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;

  // Compress code
  var compressImagePath = ''.obs;
  var compressImageSize = ''.obs;

  final RxString? imagePermanent = ''.obs;

  File? image;

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);
    DateTime now = DateTime.now();
    final oneDayFromNow = now.add(const Duration(days: 1));
    final twoDaysFromNow = now.add(const Duration(days: 2));
    final threeDaysFromNow = now.add(const Duration(days: 3));
    final fiveDaysFromNow = now.add(const Duration(days: 5));
    final eightDaysFromNow = now.add(const Duration(days: 8));
    final fifteenDaysFromNow = now.add(const Duration(days: 15));
    final twentyOneDaysFromNow = now.add(const Duration(days: 21));
    final thirtyFourDaysFromNow = now.add(const Duration(days: 34));
    final fiftyFiveDaysFromNow = now.add(const Duration(days: 55));
    final eightyNineDaysFromNow = now.add(const Duration(days: 89));
    final oneHundredFourtyFourDaysFromNow = now.add(const Duration(days: 144));
    final twoHundredThirtyThreeDaysFromNow = now.add(const Duration(days: 233));
    final threeHundredSeventySeveDaysFromNow =
        now.add(const Duration(days: 377));
    final sixHundredTenDaysFromNow = now.add(const Duration(days: 610));
    final nineHundredEightySevenDaysFromNow =
        now.add(const Duration(days: 987));

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final currentUserId = await firebaseAuth.currentUser!.uid;
    CollectionReference stories = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('storyList');

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('story_img/$now')
          .putFile(file);
      await firebase_storage.FirebaseStorage.instance
          .ref('story_img/$now')
          .getDownloadURL()
          .then((url) => stories
              .add({
                'id': '',
                'label': '',
                'remotePath': url,
                'localPath': filePath,
                'shown': false,
                'createdAt': '${now.year}/${now.month}/${now.day}',
                'iterationList': [
                  '${now.year}/${now.month}/${now.day}',
                  '${oneDayFromNow.year}/${oneDayFromNow.month}/${oneDayFromNow.day}',
                  '${twoDaysFromNow.year}/${twoDaysFromNow.month}/${twoDaysFromNow.day}',
                  '${threeDaysFromNow.year}/${threeDaysFromNow.month}/${threeDaysFromNow.day}',
                  '${fiveDaysFromNow.year}/${fiveDaysFromNow.month}/${fiveDaysFromNow.day}',
                  '${eightDaysFromNow.year}/${eightDaysFromNow.month}/${eightDaysFromNow.day}',
                  '${fifteenDaysFromNow.year}/${fifteenDaysFromNow.month}/${fifteenDaysFromNow.day}',
                  '${twentyOneDaysFromNow.year}/${twentyOneDaysFromNow.month}/${twentyOneDaysFromNow.day}',
                  '${thirtyFourDaysFromNow.year}/${thirtyFourDaysFromNow.month}/${thirtyFourDaysFromNow.day}',
                  '${fiftyFiveDaysFromNow.year}/${fiftyFiveDaysFromNow.month}/${fiftyFiveDaysFromNow.day}',
                  '${eightyNineDaysFromNow.year}/${eightyNineDaysFromNow.month}/${eightyNineDaysFromNow.day}',
                  '${oneHundredFourtyFourDaysFromNow.year}/${oneHundredFourtyFourDaysFromNow.month}/${oneHundredFourtyFourDaysFromNow.day}',
                  '${twoHundredThirtyThreeDaysFromNow.year}/${twoHundredThirtyThreeDaysFromNow.month}/${twoHundredThirtyThreeDaysFromNow.day}',
                  '${threeHundredSeventySeveDaysFromNow.year}/${threeHundredSeventySeveDaysFromNow.month}/${threeHundredSeventySeveDaysFromNow.day}',
                  '${sixHundredTenDaysFromNow.year}/${sixHundredTenDaysFromNow.month}/${sixHundredTenDaysFromNow.day}',
                  '${nineHundredEightySevenDaysFromNow.year}/${nineHundredEightySevenDaysFromNow.month}/${nineHundredEightySevenDaysFromNow.day}'
                ]
              })
              .then((value) => print('story added to firestore'))
              .catchError((error) => print('$error')));

      // return print('story_img uploaded');
      Get.snackbar('🥳your story uploaded🎉', 'storyがアップロードされました！',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print(e.message);
    }
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";

      // Crop
      final cropImageFile = await ImageCropper.cropImage(
          sourcePath: selectedImagePath.value,
          maxWidth: 512,
          maxHeight: 512,
          compressFormat: ImageCompressFormat.jpg);
      cropImagePath.value = cropImageFile!.path;
      cropImageSize.value =
          ((File(cropImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";

      // Compress

      final dir = Directory.systemTemp;
      final name = basename(cropImagePath.value);
      final targetPath = dir.absolute.path + name;
      var compressedFile = await FlutterImageCompress.compressAndGetFile(
          cropImagePath.value, targetPath,
          quality: 90);
      compressImagePath.value = compressedFile!.path;
      compressImageSize.value =
          ((File(compressImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";

      final imagePermanent = await saveImagePermanently(compressedFile.path);

      uploadFile(imagePermanent.path);
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void showCompressedFile(XFile? file) {
    Get.dialog(Center(
      child: Image.file(File(file!.path)), //Image.file(file),
    ));
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {}

  @override
  void onClose() {}
}
