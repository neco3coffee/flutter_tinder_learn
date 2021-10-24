import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  int? wpm;
  List? iteration;

  UserModel({this.uid, this.wpm, this.iteration});

  UserModel.fromMap(DocumentSnapshot data) {
    uid = data.id;
    wpm = data["wpm"];
    iteration = data["iteration"];
  }
}
