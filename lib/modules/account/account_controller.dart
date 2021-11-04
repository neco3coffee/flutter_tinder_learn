import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountController extends GetxController {
  late GoogleSignIn googleSign;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  late User user;
  @override
  void onInit() async {
    super.onInit();
    user = Get.arguments;
    if (users.doc(user.uid).isBlank!) {
      users
          .doc(user.uid)
          .set({
            'id': user.uid,
            'name': user.displayName,
            'email': user.email,
          })
          .then((value) => print("user added!"))
          .catchError((error) => print("failed to add user : $error"));
    } else {}
  }

  @override
  void onReady() async {
    googleSign = GoogleSignIn();
    super.onReady();
  }

  @override
  void onClose() {}

  void logout() async {
    await googleSign.disconnect();
    await firebaseAuth.signOut();
    await Get.offAllNamed('/google_auth');
  }
}
