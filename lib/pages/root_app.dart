import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tinder_learn/pages/account_page.dart';
import 'package:flutter_tinder_learn/pages/chat_page.dart';
import 'package:flutter_tinder_learn/pages/explore_page.dart';
import 'package:flutter_tinder_learn/pages/likes_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [ExplorePage(), LikesPage(), ChatPage(), AccountPage()],
    );
  }

  getAppBar() {
    List bottomItems = [
      pageIndex == 0
          ? Icon(
              Icons.auto_awesome_motion,
              color: Colors.pink,
              size: 36.0,
            )
          : Icon(
              Icons.auto_awesome_motion_outlined,
              color: Colors.pink,
              size: 36.0,
            ),
      pageIndex == 1
          ? Icon(
              Icons.source,
              color: Colors.pink,
              size: 36.0,
            )
          : Icon(
              Icons.source_outlined,
              color: Colors.pink,
              size: 36.0,
            )
    ];
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = index;
                });
              },
              icon: bottomItems[index],
            );
          }),
        ),
      ),
    );
  }
}
