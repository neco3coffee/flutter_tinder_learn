import 'package:flutter_tinder_learn/import.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(title: Text("counter")),
      body: Center(
        child: Text('this is payment page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () => Get.back(result: 'success'),
        //ボタンを押すと前の画面に戻り、「success」という結果を渡す
      ));
}
