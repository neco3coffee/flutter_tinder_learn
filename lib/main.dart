import 'dart:io';
import 'dart:io' as io;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// outside
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:story_view/story_view.dart';

// model

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // -------------------anonymous sign in--------------------
  // UserCredential userCredential =
  //     await FirebaseAuth.instance.signInAnonymously();
  // print(userCredential.user?.uid);
  // ---------------------------------------
  FirebaseAuth auth = FirebaseAuth.instance;
  runApp(GetMaterialApp(
    initialRoute: '/google_auth',
    defaultTransition: Transition.native,
    theme: ThemeData(
        primaryColor: Colors.lightGreen.shade200,
        appBarTheme: AppBarTheme(color: Colors.lightGreen.shade200)),
    getPages: [
      //Simple GetPage
      GetPage(
        name: '/google_auth',
        page: () => GoogleView(),
        binding: GoogleBinding(),
      ),
      GetPage(
        name: '/login',
        page: () => LoginView(),
        binding: LoginBinding(),
      ),
      GetPage(
        name: '/root',
        page: () => LandingPage(),
        binding: AccountBinding(),
      ),
      GetPage(
        name: '/home',
        page: () => HomeView(),
        binding: HomeBinding(),
      ),
      GetPage(
        name: '/account',
        page: () => AccountView(),
        binding: AccountBinding(),
      ),
      GetPage(
        name: '/add_image',
        page: () => AddImageView(),
        binding: AddImageBinding(),
      ),
      GetPage(
        name: '/story',
        page: () => MoreStories(auth.currentUser),
        // binding: StoryBinding(),
      ),
    ],
  ));
}

// GoogleAuth----------------
// view
class GoogleView extends GetView<GoogleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          // child: CircularProgressIndicator(
          //   valueColor: AlwaysStoppedAnimation(Colors.yellowAccent),
          // ),
          child: Text('pending')),
    );
  }
}

// controller
class GoogleController extends GetxController {
  late GoogleSignIn googleSign;
  var isSignIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    googleSign = GoogleSignIn();
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = await firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });

    super.onReady();
  }

  @override
  void onClose() {}

  void handleAuthStateChanged(isLoggedIn) {
    if (isLoggedIn) {
      Get.offAllNamed('/root', arguments: firebaseAuth.currentUser);
    } else {
      Get.offAllNamed('/login');
    }
  }
}

// binding

class GoogleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GoogleController>(GoogleController());
  }
}
// ____________________________________________GoogleAUth

// LoginView------------------------------
// view
class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.asset(
          //   "images/instantLearn.png",
          // ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Google SignIn",
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: context.width),
              child: ElevatedButton(
                child: Text(
                  "Sign In with Google",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                onPressed: () {
                  controller.login();
                },
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

// controller
class LoginController extends GetxController {
  GoogleController googleController = Get.find<GoogleController>();

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void login() async {
    CustomFullScreenDialog.showDialog();
    GoogleSignInAccount? googleSignInAccount =
        await googleController.googleSign.signIn();
    if (googleSignInAccount == null) {
      CustomFullScreenDialog.cancelDialog();
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await googleController.firebaseAuth.signInWithCredential(oAuthCredential);
      CustomFullScreenDialog.cancelDialog();
    }
  }
}

// binding
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}

// --------------------------------LoginView

// AccountView--------------------------
class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AccountPage'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(controller.user.photoURL!),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${controller.user.displayName}',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 120),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreen.shade400)),
                child: Text("Logout",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                onPressed: () {
                  controller.logout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountController extends GetxController {
  // GoogleController googleController = Get.find<GoogleController>();
  late GoogleSignIn googleSign;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // var isSignIn = true.obs;
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
    } else {
      print('already your account is stored on firestore');
    }
  }

  @override
  void onReady() async {
    googleSign = GoogleSignIn();
    // ever(isSignIn, handleAuthStateChanged);
    // isSignIn.value = await firebaseAuth.currentUser != null;
    // firebaseAuth.authStateChanges().listen((event) {
    //   isSignIn.value = event != null;
    // });
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

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AccountController>(AccountController());
    Get.put<AddImageController>(AddImageController());
    Get.put<HomeController>(HomeController());
    Get.lazyPut<GoogleController>(() => GoogleController());
  }
}

// ------------------------AccountView

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
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              // NotePage(),
              HomeView(),
              AddImageView(),
              AccountView(),
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

  void saveUpdateNote(
      String title, String description, String docId, int addEditFlag) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    if (addEditFlag == 1) {
      CustomFullScreenDialog.showDialog();
      notesReference.add({
        'docId': docId,
        'title': title,
        'description': description,
        'image':
            'http://beepeers.com/assets/images/commerces/default-image.jpg',
        'local_image_path': 'device_path',
        'remote_image_path': 'firebase_storage_path',
        'userId': auth.currentUser!.uid
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "note Added",
            message: "note added successfully",
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
      notesReference.doc(docId).update({
        'title': title,
        'description': description,
        'docId': docId
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "note Updated",
            message: "note updated successfully",
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
      .map((query) =>
          query.docs.map((note) => NoteModel.fromMap(note)).toList());

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
          title: "note Deleted",
          message: "note deleted successfully",
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
          _buildAddEditNoteView(text: 'ADD', addEditFlag: 1, docId: "");
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
                    _buildAddEditNoteView(
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

  _buildAddEditNoteView({String? text, int? addEditFlag, String? docId}) {
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
                          hintText: 'Title',
                          labelText: 'タイトル',
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
                          labelText: '説明文',
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
                            controller.saveUpdateNote(
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
      title: "Delete note",
      titleStyle: TextStyle(fontSize: 20),
      middleText: 'Are you sure to delete note ?',
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
// HomeView-----------------------------------

class HomeView extends GetView<HomeController> {
  // HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('👀instantLearn✌️'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Get.toNamed('/add_image');
                          },
                          child: Container(
                            width: 65,
                            height: 65,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${controller.auth.currentUser!.photoURL}'),
                                          fit: BoxFit.cover)),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 19,
                                      height: 19,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Icon(
                                        Icons.add_circle,
                                        color: Colors.pink,
                                        size: 19,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        // SizedBox(
                        //   width: 70,
                        //   child: Text(
                        //     'shunta',
                        //     overflow: TextOverflow.ellipsis,
                        //     style: TextStyle(color: Colors.black),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 65,
                          height: 65,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/instantLearn.png'),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 65,
                          height: 65,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/instantLearn.png'),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 65,
                          height: 65,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/instantLearn.png'),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 65,
                          height: 65,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/instantLearn.png'),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 15, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 65,
                          height: 65,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/instantLearn.png'),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Get.toNamed('/story');
                },
                child: Container(
                  width: 150,
                  height: 150,
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                '${controller.auth.currentUser!.photoURL}'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
          ],
        )

        // body: Center(
        //   child:
        //       // Text('homeview')
        //       // Obx(() => Text(controller.stories[0]['remotePath']))),
        //       Obx(
        //     () => ListView.builder(
        //       itemCount: controller.stories.length,
        //       itemBuilder: (BuildContext ctxt, int index) {
        //         bool existLocal = controller.stories[index]['localPath'] != '';
        //         if (existLocal) {
        //           print('🏁ローカルpathからイメージを表示してるよ');
        //           return Image.file(File(controller.stories[index]['localPath']));
        //         } else {
        //           print('🏁リモートpathからイメージを表示してるよ');
        //           return Image.network(controller.stories[index]['remotePath']);
        //         }
        //       },
        //     ),
        //   ),
        // ),
        );
  }
}

class HomeController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late CollectionReference storiesReference;
  late List stories = [].obs;
  late String name = 'shunta';

  @override
  void onInit() {
    print('👀HomeController');
    super.onInit();

    late String userId = auth.currentUser!.uid;
    storiesReference = firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("storyList");

    storiesReference.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((story) {
        print(story["remotePath"]);
        stories.add(story.data());
        print('storiesList can be used from HomeView Now🔥');
        print(stories[0]);
      });
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  // void deleteData(String docId) {
  //   CustomFullScreenDialog.showDialog();
  //   notesReference.doc(docId).delete().whenComplete(() {
  //     CustomFullScreenDialog.cancelDialog();
  //     Get.back();
  //     CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "note Deleted",
  //         message: "note deleted successfully",
  //         backgroundColor: Colors.green);
  //   }).catchError((error) {
  //     CustomFullScreenDialog.cancelDialog();
  //     CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Error",
  //         message: "Something went wrong",
  //         backgroundColor: Colors.red);
  //   });
  // }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    // Get.put<GoogleController>(GoogleController());
  }
}

// -----------------------------------HomeView

// AddImageView-------------------------
class AddImageView extends GetView<AddImageController> {
  @override
  Widget build(BuildContext context) {
    if (controller.imagePermanent != '') {
      print(controller.imagePermanent);
    } else {
      print('yooooo');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('AddImageView'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ConstrainedBox(
            //   constraints: BoxConstraints.tightFor(width: 120),
            //   child: ElevatedButton(
            //     child: Text(
            //       "showImageModal",
            //       style: TextStyle(fontSize: 16, color: Colors.black),
            //     ),
            //     onPressed: () {
            //       showImageSource(context);
            //     },
            //   ),
            // ),

            // ElevatedButton(
            //   style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all(Colors.white)),
            //   onPressed: () {
            //     controller.getImage(ImageSource.gallery);
            //     // controller.pickImage();
            //   },
            //   child: CircleAvatar(
            //     radius: 70,
            //     backgroundImage: AssetImage('assets/images/gallery.png'),
            //     backgroundColor: Colors.lightGreen.shade200,
            //   ),
            // ),
            IconButton(
              icon: Icon(
                Icons.image,
              ),
              iconSize: 90,
              color: Colors.lightGreen.shade400,
              splashColor: Colors.lightGreen.shade100,
              onPressed: () {
                controller.getImage(ImageSource.gallery);
              },
            ),
            SizedBox(
              width: 30,
            ),
            IconButton(
              icon: Icon(
                Icons.camera_alt,
              ),
              iconSize: 90,
              color: Colors.lightGreen.shade400,
              splashColor: Colors.lightGreen.shade100,
              onPressed: () {
                controller.getImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddImageController extends GetxController {
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

  // void pickImage() async {
  //   final XFile? image =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image == null) return;

  //   final imagePermanent = await saveImagePermanently(image.path);

  //   // final imageTemporary = XFile(image.path);
  //   // this.image = imageTemporary;
  //   print(imagePermanent);
  //   print(image.path);
  //   showCompressedFile(image);
  // }

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
      print('🔥urlだよおおおおおおおおおお');
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

      print(compressedFile);
      final imagePermanent = await saveImagePermanently(compressedFile.path);
      print('make permanent🔥');
      print(imagePermanent);

      uploadFile(imagePermanent.path);
      // uploadImage(compressedFile);
      // showCompressedFile(compressedFile);
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

    print('👀AddImageController onInit');
  }

  @override
  void onReady() async {
    print('👀AddImageController onReady');
  }

  @override
  void onClose() {
    print('👀AddImageController onClose');
  }

  // void logout() async {
  //   await googleSign.disconnect();
  //   await firebaseAuth.signOut();
  //   await Get.offAllNamed('/google_auth');
  // }
}

class AddImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddImageController>(AddImageController());
    // Get.put<GoogleController>(GoogleController());
  }
}

Future<dynamic> showImageSource(BuildContext context) async {
  return showModalBottomSheet(
      context: context,
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () => Get.toNamed('/account'),
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Gallery'),
                onTap: () => Get.toNamed('/root'),
              ),
            ],
          ));
}

// ------------------------------AddImageView

// StoryView----------------------------------

// class StoryView extends GetView<StoryController> {
//   // @override
//   // void dispose() {
//   //   controller.storyController.dispose();
//   //   // super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('StoryView'),
//       ),
//       // body: storyC.StoryView(
//       //   storyItems: [
//       //     storyC.StoryItem.text(
//       //       title: "英語！！教科書９ぺーじ〜！",
//       //       backgroundColor: Colors.blue,
//       //     ),
//       //     storyC.StoryItem.text(
//       //       title: "Nice!\n\nTap to continue.",
//       //       backgroundColor: Colors.red,
//       //       textStyle: TextStyle(
//       //         fontFamily: 'Dancing',
//       //         fontSize: 40,
//       //       ),
//       //     ),
//       //     // storyC.StoryItem.pageImage(
//       //     //   url:
//       //     //       "https://firebasestorage.googleapis.com/v0/b/flutter-tinder-learn.appspot.com/o/eng1.jpg?alt=media&token=7a1b0866-58cc-4bf0-8013-16c0106deac2",
//       //     //   caption: "Still sampling",
//       //     //   controller: storyController,
//       //     // ),
//       //     // storyC.StoryItem.pageImage(
//       //     //     url:
//       //     //         "https://firebasestorage.googleapis.com/v0/b/flutter-tinder-learn.appspot.com/o/eng2.jpg?alt=media&token=15a59884-64e7-4559-ab0d-5e090ff9913b",
//       //     //     caption: "Working with gifs",
//       //     //     controller: storyController),
//       //     // storyC.StoryItem.pageImage(
//       //     //   url:
//       //     //       "https://firebasestorage.googleapis.com/v0/b/flutter-tinder-learn.appspot.com/o/eng4.jpg?alt=media&token=04d999a9-81cc-422a-a082-0934aeb0c28d",
//       //     //   caption: "Hello, from the other side",
//       //     //   controller: storyController,
//       //     // ),
//       //     // storyC.StoryItem.pageImage(
//       //     //   url:
//       //     //       "https://firebasestorage.googleapis.com/v0/b/flutter-tinder-learn.appspot.com/o/eng5.jpg?alt=media&token=fa46d1a4-cf85-4739-8ab5-92c47b476807",
//       //     //   caption: "Hello, from the other side2",
//       //     //   controller: storyController,
//       //     // ),
//       //   ],
//       //   onStoryShow: (s) {
//       //     print("Showing a story");
//       //   },
//       //   onComplete: () {
//       //     print("Completed a cycle");
//       //   },
//       //   progressPosition: storyC.ProgressPosition.top,
//       //   repeat: false,
//       //   controller: storyC.StoryController(),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image(
//               width: 200,
//               height: 200,
//               image: NetworkImage(
//                   'https://firebasestorage.googleapis.com/v0/b/flutter-tinder-learn.appspot.com/o/story_img%2F2021-10-31%2023%3A56%3A36.281937?alt=media&token=4dd23aaa-2352-47be-9d23-5f0cd57af34d'),
//             ),
//             Text('storyView')
//           ],
//         ),
//       ),
//     );
//   }
// }

// class StoryController extends GetxController {
//   final sController = StoryController();
//   @override
//   void onInit() async {
//     super.onInit();

//     print('👀AddImageController onInit');
//   }

//   @override
//   void onReady() async {
//     print('👀AddImageController onReady');
//   }

//   @override
//   void onClose() {
//     print('👀AddImageController onClose');
//   }
// }

// class StoryBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put<StoryController>(StoryController());
//     // Get.put<GoogleController>(GoogleController());
//   }
// }
// ----------------------------StoryView

class MoreStories extends StatefulWidget {
  late User? user;

  MoreStories(this.user);

  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();
  var showStoryUrlList = [];

  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // FirebaseAuth auth = FirebaseAuth.instance;
  //  late CollectionReference storiesReference;
  // late List stories = [];
  // late String userId = auth.currentUser!.uid;
  //   storiesRef = firebaseFirestore
  //       .collection("users")
  //       .doc(userId)
  //       .collection("storyList");

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.user!.uid),
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user!.uid)
            .collection('storyList')
            .orderBy('createdDay', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('error:${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            // ローディング
            return const Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Linear progress indicator',
              ),
            );
          }

          // return ListView(
          //     children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          //   return ListTile(
          //     title: Text("${data['remotePath']}"),
          //   );
          // }).toList());

          // return ListView.builder(itemCount: , itemBuilder: (context, index) {
          // snapshot.data!.docs.map((DocumentSnapshot document) {
          //   Map<String, dynamic> data =
          //       document.data() as Map<String, dynamic>;
          // print(data);
          // print('🐞🔥🐞')

          // });
          //   return StoryView(storyItems: [
          //     StoryItem.pageImage(
          //         controller: storyController,
          //         url:'https://firebasestorage.googleapis.com/v0/b/flutter-tinder-learn.appspot.com/o/story_img%2F2021-11-02%2013%3A50%3A34.801252?alt=media&token=695f70a9-95ae-4ddb-819a-4890899ad3e5'),
          //   ],
          //   controller: storyController,
          //   progressPosition: ProgressPosition.top,
          //   repeat: false,
          //   );
          // });

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
                  print(
                      "🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️ ${data['createdDay']} 🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️🏃‍♂️");
                  return StoryItem.pageImage(
                      controller: storyController, url: data['remotePath']);
                }).toList());
          }
        },
      ),
    );
  }
}
