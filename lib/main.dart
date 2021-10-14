// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // DatabaseReference usersRef =
  //     FirebaseDatabase.instance.reference().child("users");
  // UserCredential userCredential =
  //     await FirebaseAuth.instance.signInAnonymously();
  // print(userCredential.user?.uid);
  // print(firebaseAuth.app.hashCode);
  runApp(MaterialApp(home: App()));
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // // Check for errors
          // if (snapshot.hasError) {
          //   return SomethingWentWrong();
          // }

          // // Once complete, show your application
          // if (snapshot.connectionState == ConnectionState.done) {
          //   return MyAwesomeApp();
          // }

          // // Otherwise, show something whilst waiting for initialization to complete
          // return Loading();
          List<Widget> children;
          // if (snapshot.hasData) {
          //   children = <Widget>[
          //     const Icon(
          //       Icons.check_circle_outline,
          //       color: Colors.green,
          //       size: 60,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 16),
          //       child: Text('Result: ${snapshot.data}'),
          //     )
          //   ];
          // }
          if (snapshot.connectionState == ConnectionState.done) {
            children = <Widget>[
              const Icon(
                Icons.connect_without_contact_outlined,
                color: Colors.green,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Page: ${snapshot.data}'),
              ),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.black,
                child: Container(
                  height: 50.0,
                  child: Center(
                    child: Text(
                      "Create Account",
                      style:
                          TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                    ),
                  ),
                ),
                onPressed: () {
                  // registerNewUser(context);
                  registerNewUser(context);
                },
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}

void registerNewUser(BuildContext context) async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  DatabaseReference usersRef =
      FirebaseDatabase.instance.reference().child("users");
  UserCredential userCredential =
      await FirebaseAuth.instance.signInAnonymously();
  print(userCredential.user?.uid);
  Map userDataMap = {
    "wpm": 50,
    "iteration": [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]
  };
  usersRef.child(userCredential.user!.uid).set(userDataMap);
}
