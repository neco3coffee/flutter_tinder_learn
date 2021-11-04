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
                'createdDay': now,
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
