import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

// outside
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

// model

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // authentication-----------------------------
  // FirebaseAuth auth = FirebaseAuth.instance;
  // auth.authStateChanges().listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //     // auth.instance.currentUser!.
  //   }
  // });

  UserCredential userCredential =
      await FirebaseAuth.instance.signInAnonymously();
  print(userCredential.user?.uid);

  // late CollectionReference usersReference;
  // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // usersReference = firebaseFirestore.collection("users");
  // usersReference.add({
  //   'uid': userCredential.user?.uid,
  //   'wpm': 40,
  //   'iteration': [
  //     0,
  //     1,
  //     2,
  //     3,
  //     5,
  //     8,
  //     13,
  //     21,
  //     34,
  //     55,
  //     89,
  //     144,
  //     233,
  //     377,
  //     610,
  //     987,
  //     1597,
  //     2584,
  //     4181,
  //     6765,
  //     10946
  //   ]
  // }).whenComplete(() {
  //   print("user登録完了👍");
  // }).catchError((error) {
  //   print("user登録失敗❌");
  // });

  // -------------------------------authentication

  runApp(GetMaterialApp(
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    initialRoute: '/home',
    defaultTransition: Transition.native,
    locale: Locale('pt', 'BR'),
    getPages: [
      //Simple GetPage
      GetPage(name: '/home', page: () => LandingPage(), binding: NoteBinding()),
      // GetPage with custom transitions and bindings
      GetPage(
        name: '/note',
        page: () => NotePage(),
        // binding: NoteBinding(),
      ),
      // // GetPage with default transitions
      // GetPage(
      //   name: '/swipe',
      //   transition: Transition.cupertino,
      //   page: () => Swipe(),
      // ),
      // GetPage(
      //   name: '/scroll',
      //   transition: Transition.cupertino,
      //   page: () => Scroll(),
      // ),
    ],
  ));
}

// CustomSnackBar--------------------------
class CustomSnackBar {
  static void showSnackBar({
    required BuildContext? context,
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        titleText: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        messageText: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
        colorText: Colors.white,
        borderRadius: 8,
        margin: EdgeInsets.all(16));
  }
}

// -------------------------CustomSnackBar

// CustomFullScreenDialog -------------------
class CustomFullScreenDialog {
  static void showDialog() {
    Get.dialog(
      WillPopScope(
        child: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: Color(0xff141A31).withOpacity(.3),
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    Get.back();
  }
}

// -------------------CustomFullScreenDialog

class LandingPageController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class LandingPage extends StatelessWidget {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.9),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 54,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: Colors.white,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.note_add_outlined,
                    size: 20.0,
                  ),
                ),
                label: 'Note',
                backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.play_lesson_outlined,
                    size: 20.0,
                  ),
                ),
                label: 'Explore',
                backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.file_copy_outlined,
                    size: 20.0,
                  ),
                ),
                label: 'Review',
                backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.settings,
                    size: 20.0,
                  ),
                ),
                label: 'Settings',
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
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              NotePage(),
              ExplorePage(),
              PlacesPage(),
              SettingsPage(),
            ],
          )),
    ));
  }
}

class NoteModel {
  String? docId;
  String? title;
  String? description;
  String? image;
  String? userId;

  NoteModel(
      {this.docId, this.title, this.description, this.image, this.userId});

  NoteModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    title = data["title"];
    description = data["description"];
    image = data["image"];
    userId = data["userId"];
  }

  static fromSnapshot(QueryDocumentSnapshot<Object?> e) {}
}

class NoteController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController, addressController;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late CollectionReference notesReference;
  RxList<NoteModel> notes = RxList<NoteModel>([]);

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    addressController = TextEditingController();
    notesReference = firebaseFirestore.collection("notes");
    late String userId = auth.currentUser!.uid;
    notes.bindStream(getAllNotes(userId));
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Name can not be empty";
    }
    return null;
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Address can not be empty";
    }
    return null;
  }

  void saveUpdateEmployee(
      String title, String description, String docId, int addEditFlag) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    if (addEditFlag == 1) {
      CustomFullScreenDialog.showDialog();
      notesReference.add({
        'title': title,
        'description': description,
        'image':
            'http://beepeers.com/assets/images/commerces/default-image.jpg',
        'userId': auth.currentUser!.uid
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Employee Added",
            message: "Employee added successfully",
            backgroundColor: Colors.green);
      }).catchError((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Error",
            message: "Something went wrong",
            backgroundColor: Colors.green);
      });
    } else if (addEditFlag == 2) {
      //update
      CustomFullScreenDialog.showDialog();
      notesReference.doc(docId).update(
          {'title': title, 'description': description}).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Employee Updated",
            message: "Employee updated successfully",
            backgroundColor: Colors.green);
      }).catchError((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Error",
            message: "Something went wrong",
            backgroundColor: Colors.red);
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
  }

  Stream<List<NoteModel>> getAllNotes(String? userId) => notesReference
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((query) => query.docs.map((note) =>
          // noteのuserIdがauth.currentUser!.uidと一致したものだけを引っ張ってくる。
          NoteModel.fromMap(note)).toList());

  void clearEditingControllers() {
    nameController.clear();
    addressController.clear();
  }

  void deleteData(String docId) {
    CustomFullScreenDialog.showDialog();
    notesReference.doc(docId).delete().whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      Get.back();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Employee Deleted",
          message: "Employee deleted successfully",
          backgroundColor: Colors.green);
    }).catchError((error) {
      CustomFullScreenDialog.cancelDialog();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong",
          backgroundColor: Colors.red);
    });
  }
}

class NoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteController>(
      () => NoteController(),
    );
  }
}

class NotePage extends GetView<NoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.clearEditingControllers();
          _buildAddEditEmployeeView(text: 'ADD', addEditFlag: 1, docId: '');
        }, //newNote
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Note'),
      ),
      body: Obx(
        () => GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.618,
              mainAxisSpacing: 16.8,
              crossAxisSpacing: 10.0),
          itemCount: controller.notes.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("${controller.notes[index].image}"),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter),
                ),
                child: InkWell(
                  onTap: () {
                    controller.nameController.text =
                        controller.notes[index].title!;
                    controller.addressController.text =
                        controller.notes[index].description!;
                    _buildAddEditEmployeeView(
                        text: 'UPDATE',
                        addEditFlag: 2,
                        docId: controller.notes[index].docId!);
                  },
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "${controller.notes[index].title}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                        subtitle:
                            Text("${controller.notes[index].description}"),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildAddEditEmployeeView({String? text, int? addEditFlag, String? docId}) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                    displayDeleteDialog(docId!);
                  },
                  child: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  )),
              SizedBox(height: 5),
              Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${text} Note',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        controller: controller.nameController,
                        validator: (value) {
                          return controller.validateName(value!);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        controller: controller.addressController,
                        validator: (value) {
                          return controller.validateAddress(value!);
                        },
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: Get.context!.width, height: 45),
                        child: ElevatedButton(
                          child: Text(
                            text!,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          onPressed: () {
                            controller.saveUpdateEmployee(
                                controller.nameController.text,
                                controller.addressController.text,
                                docId!,
                                addEditFlag!);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  displayDeleteDialog(String? docId) {
    Get.defaultDialog(
      title: "Delete Employee",
      titleStyle: TextStyle(fontSize: 20),
      middleText: 'Are you sure to delete employee ?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.black,
      onCancel: () {},
      onConfirm: () {
        controller.deleteData(docId!);
      },
    );
  }
}

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExplorePage'),
      ),
    );
  }
}

class PlacesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review'),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SettingsPage'),
      ),
    );
  }
}
