// @dart=2.9
import 'package:flutter/material.dart';
// import 'package:tinder_clone/pages/root_app.dart';
import 'package:flutter_tinder_learn/pages/root_app.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScrapBox(),
      // home: RootPage(),
    ),
  );
}

class ScrapBox extends StatefulWidget {
  // const ScrapBox({ Key? key }) : super(key: key);
  var response =
      http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  @override
  _ScrapBoxState createState() => _ScrapBoxState();
}

class _ScrapBoxState extends State<ScrapBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network(
        'https://1.bp.blogspot.com/-jlZlCg-8FAM/Xub_u8HTD1I/AAAAAAABZis/ZhUI05AZBEQpVinedZ6Xy-eIucmNuY2SQCNcBGAsYHQ/s1600/pose_pien_uruuru_man.png',
      ),
    );
  }
}
