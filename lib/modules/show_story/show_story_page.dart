import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class MoreStories extends StatefulWidget {
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  initState() {
    super.initState();
    final DateTime now = DateTime.now();
    final todaydayo = '${now.year}/${now.month}/${now.day}';
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('storyList')
            .where('iterationList',
                arrayContains: '${now.year}/${now.month}/${now.day}')
            // .orderBy('createdDay', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('error:${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Linear progress indicator',
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Center(
              child: Text('storyがありません！'),
            ));
          } else {
            return StoryView(
                controller: storyController,
                progressPosition: ProgressPosition.top,
                repeat: false,
                storyItems:
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return StoryItem.pageImage(
                      controller: storyController, url: data['remotePath']);
                }).toList());
          }
        },
      ),
    );
  }
}
