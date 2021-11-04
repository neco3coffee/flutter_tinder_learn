import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel {
  String? docId;
  String? label;
  String? remotePath;
  String? localPath;
  bool? shown;
  DateTime? createdDay;

  StoryModel(
      {this.docId,
      this.label,
      this.remotePath,
      this.localPath,
      this.shown,
      this.createdDay});

  StoryModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    label = data['label'];
    remotePath = data['remotePath'];
    localPath = data['localPath'];
    shown = data['shown'];
    createdDay = data['createdDay'];
  }
}
