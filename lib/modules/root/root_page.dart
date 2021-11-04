import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'root.dart';
import '../home/home.dart';
import '../add_story/add_story.dart';
import '../account/account.dart';

class RootPage extends StatelessWidget {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.9),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, rootPageController) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 54,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: rootPageController.changeTabIndex,
            currentIndex: rootPageController.tabIndex.value,
            backgroundColor: Colors.lightGreen.shade200,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: Colors.white,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              // BottomNavigationBarItem(
              //   icon: Container(
              //     margin: EdgeInsets.only(bottom: 7),
              //     child: Icon(
              //       Icons.note_add_outlined,
              //       size: 20.0,
              //     ),
              //   ),
              //   label: 'Note',
              //   backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
              // ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.home,
                    size: 20.0,
                  ),
                ),
                label: 'Home',
                backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    size: 20.0,
                  ),
                ),
                label: 'AddStory',
                backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.manage_accounts_outlined,
                    size: 20.0,
                  ),
                ),
                label: 'Account',
                backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final RootPageController rootPageController =
        Get.put(RootPageController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, rootPageController),
      body: Obx(() => IndexedStack(
            index: rootPageController.tabIndex.value,
            children: [
              // NotePage(),
              HomeView(),
              AddStoryView(),
              AccountView(),
            ],
          )),
    ));
  }
}
