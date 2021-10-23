// // ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter/material.dart';

// // Import the firebase_core plugin
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//   // DatabaseReference usersRef =
//   //     FirebaseDatabase.instance.reference().child("users");
//   // UserCredential userCredential =
//   //     await FirebaseAuth.instance.signInAnonymously();
//   // print(userCredential.user?.uid);
//   // print(firebaseAuth.app.hashCode);
//   runApp(MaterialApp(home: App()));
// }

// class App extends StatefulWidget {
//   // Create the initialization Future outside of `build`:
//   @override
//   _AppState createState() => _AppState();
// }

// class _AppState extends State<App> {
//   /// The future is part of the state of our widget. We should not call `initializeApp`
//   /// directly inside [build].
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//   final Future<String> _calculation = Future<String>.delayed(
//     const Duration(seconds: 2),
//     () => 'Data Loaded',
//   );

//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         // Initialize FlutterFire:
//         future: _initialization,
//         builder: (context, snapshot) {
//           // // Check for errors
//           // if (snapshot.hasError) {
//           //   return SomethingWentWrong();
//           // }

//           // // Once complete, show your application
//           // if (snapshot.connectionState == ConnectionState.done) {
//           //   return MyAwesomeApp();
//           // }

//           // // Otherwise, show something whilst waiting for initialization to complete
//           // return Loading();
//           List<Widget> children;
//           // if (snapshot.hasData) {
//           //   children = <Widget>[
//           //     const Icon(
//           //       Icons.check_circle_outline,
//           //       color: Colors.green,
//           //       size: 60,
//           //     ),
//           //     Padding(
//           //       padding: const EdgeInsets.only(top: 16),
//           //       child: Text('Result: ${snapshot.data}'),
//           //     )
//           //   ];
//           // }
//           if (snapshot.connectionState == ConnectionState.done) {
//             children = <Widget>[
//               const Icon(
//                 Icons.connect_without_contact_outlined,
//                 color: Colors.green,
//                 size: 60,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 16),
//                 child: Text('Page: ${snapshot.data}'),
//               ),
//               RaisedButton(
//                 color: Colors.blue,
//                 textColor: Colors.black,
//                 child: Container(
//                   height: 50.0,
//                   child: Center(
//                     child: Text(
//                       "Create Account",
//                       style:
//                           TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
//                     ),
//                   ),
//                 ),
//                 onPressed: () {
//                   // registerNewUser(context);
//                   registerNewUser(context);
//                 },
//               ),
//             ];
//           } else if (snapshot.hasError) {
//             children = <Widget>[
//               const Icon(
//                 Icons.error_outline,
//                 color: Colors.red,
//                 size: 100,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Text('Error: ${snapshot.error}'),
//               )
//             ];
//           } else {
//             children = const <Widget>[
//               SizedBox(
//                 child: CircularProgressIndicator(),
//                 width: 60,
//                 height: 60,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 16),
//                 child: Text('Awaiting result...'),
//               )
//             ];
//           }
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: children,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// void registerNewUser(BuildContext context) async {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//   DatabaseReference usersRef =
//       FirebaseDatabase.instance.reference().child("users");
//   UserCredential userCredential =
//       await FirebaseAuth.instance.signInAnonymously();
//   print(userCredential.user?.uid);
//   Map userDataMap = {
//     "wpm": 50,
//     "iteration": [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]
//   };
//   usersRef.child(userCredential.user!.uid).set(userDataMap);

//   bool isLoggedIn() {
//     return firebaseAuth.currentUser != null;
//   }

//   print(isLoggedIn());
// }

// // void display(BuildContext context) async {
// //   print(userCredential.user?.uid);
// // }

// ------------------------------------
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// outside
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  NoteModel({this.docId, this.title, this.description, this.image});

  NoteModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    title = data["title"];
    description = data["description"];
    image = data["image"];
  }
}

class NoteController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController, addressController;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  RxList<NoteModel> notes = RxList<NoteModel>([]);

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    addressController = TextEditingController();
    collectionReference = firebaseFirestore.collection("notes");
    notes.bindStream(getAllNotes());
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
      collectionReference.add({
        'title': title,
        'description': description,
        'image': 'http://beepeers.com/assets/images/commerces/default-image.jpg'
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
      collectionReference.doc(docId).update(
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

  Stream<List<NoteModel>> getAllNotes() => collectionReference.snapshots().map(
      (query) => query.docs.map((item) => NoteModel.fromMap(item)).toList());

  void clearEditingControllers() {
    nameController.clear();
    addressController.clear();
  }

  void deleteData(String docId) {
    CustomFullScreenDialog.showDialog();
    collectionReference.doc(docId).delete().whenComplete(() {
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
          print(controller.notes.length);
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
                      // Text("${notes[index]['title']}"),
                      // Text("${notes[index]['description']}"),
                      // Image.network("${notes[index]['image']}")
                      ListTile(
                        title: Text(
                          "${controller.notes[index].title}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                        // subtitle: Text("${notes[index]['description']}"),
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
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${text} Note',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    height: 8,
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
        ),
      ),
    );
  }

  displayDeleteDialog(String docId) {
    Get.defaultDialog(
      title: "Delete Employee",
      titleStyle: TextStyle(fontSize: 20),
      middleText: 'Are you sure to delete employee ?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.black,
      onCancel: () {},
      onConfirm: () {
        controller.deleteData(docId);
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
// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // leading: IconButton(
//         //   icon: Icon(Icons.add),
//         //   onPressed: () {
//         //     Get.snackbar("Hi", "I'm modern snackbar");
//         //   },
//         // ),
//         title: Text("hello shunta"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: Text('ログインする'),
//               onPressed: () {
//                 Get.toNamed('/note');
//               },
//             ),
//             // ElevatedButton(
//             //   child: Text('Change locale to English'),
//             //   onPressed: () {
//             //     Get.updateLocale(Locale('en', 'UK'));
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Note extends GetView<ControllerX> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Note'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('~~のノート'),
//           Text('~~のノート'),
//           Text('~~のノート'),
//           Text('~~のノート'),
//           Text('~~のノート'),
//         ],
//       ),
//       bottomNavigationBar: ,
//     );
//   }
// }

// class Swipe extends GetView<ControllerX> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(onPressed: () {
//         controller.incrementList();
//       }),
//       appBar: AppBar(
//         title: Text("Third ${Get.arguments}"),
//       ),
//       body: Center(
//           child: Obx(() => ListView.builder(
//               itemCount: controller.list.length,
//               itemBuilder: (context, index) {
//                 return Text("${controller.list[index]}");
//               }))),
//     );
//   }
// }

// class Scroll extends GetView<ControllerX> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(onPressed: () {
//         controller.incrementList();
//       }),
//       appBar: AppBar(
//         title: Text("Third ${Get.arguments}"),
//       ),
//       body: Center(
//           child: Obx(() => ListView.builder(
//               itemCount: controller.list.length,
//               itemBuilder: (context, index) {
//                 return Text("${controller.list[index]}");
//               }))),
//     );
//   }
// }

// class SampleBind extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<ControllerX>(() => ControllerX());
//   }
// }

// class User {
//   User({this.name = 'Name', this.age = 0});
//   String name;
//   int age;
// }

// class ControllerX extends GetxController {
//   final count1 = 0.obs;
//   final count2 = 0.obs;
//   final list = [56].obs;
//   final user = User().obs;

//   updateUser() {
//     user.update((value) {
//       value!.name = 'Jose';
//       value.age = 30;
//     });
//   }

//   /// Once the controller has entered memory, onInit will be called.
//   /// It is preferable to use onInit instead of class constructors or initState method.
//   /// Use onInit to trigger initial events like API searches, listeners registration
//   /// or Workers registration.
//   /// Workers are event handlers, they do not modify the final result,
//   /// but it allows you to listen to an event and trigger customized actions.
//   /// Here is an outline of how you can use them:

//   /// made this if you need cancel you worker
//   late Worker _ever;

//   @override
//   onInit() {
//     /// Called every time the variable $_ is changed
//     _ever = ever(count1, (_) => print("$_ has been changed (ever)"));

//     everAll([count1, count2], (_) => print("$_ has been changed (everAll)"));

//     /// Called first time the variable $_ is changed
//     once(count1, (_) => print("$_ was changed once (once)"));

//     /// Anti DDos - Called every time the user stops typing for 1 second, for example.
//     debounce(count1, (_) => print("debouce$_ (debounce)"),
//         time: Duration(seconds: 1));

//     /// Ignore all changes within 1 second.
//     interval(count1, (_) => print("interval $_ (interval)"),
//         time: Duration(seconds: 1));
//   }

//   int get sum => count1.value + count2.value;

//   increment() => count1.value++;

//   increment2() => count2.value++;

//   disposeWorker() {
//     _ever.dispose();
//     // or _ever();
//   }

//   incrementList() => list.add(75);
// }

// class SizeTransitions extends CustomTransition {
//   @override
//   Widget buildTransition(
//       BuildContext context,
//       Curve? curve,
//       Alignment? alignment,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child) {
//     return Align(
//       alignment: Alignment.center,
//       child: SizeTransition(
//         sizeFactor: CurvedAnimation(
//           parent: animation,
//           curve: curve!,
//         ),
//         child: child,
//       ),
//     );
//   }
// }
