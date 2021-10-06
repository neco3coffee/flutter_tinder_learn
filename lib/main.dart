import 'package:flutter_tinder_learn/import.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// widget
import 'package:flutter_tinder_learn/payment.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('myDB');
  box.put('name', 'David');
  print("まだアプリを実行してないよ！");
  runApp(MyApp());
  print("アプリが実行されました！");
  print(box.get('name'));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: Counter(),
    );
  }
}

class CounterController extends GetxController {
  final count = 0.obs;
}

class Counter extends StatelessWidget {
  final cc = Get.put(CounterController());
  //これでccという名前でCounterControllerを使える

  @override
  Widget build(context) {
    ever(cc.count, (value) => print("$value has been changed"));
    return Scaffold(
        appBar: AppBar(title: Text("counter")),
        body: Center(
          child: Row(
            children: [
              Obx(() => Text("${cc.count.value}")),
              RaisedButton(
                onPressed: () async {
                  var data = await Get.to(() => PaymentPage());
                  print(data);
                },
                child: Icon(Icons.arrow_forward),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => cc.count.value++,
        ));
  }
}
