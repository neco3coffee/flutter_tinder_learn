// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
    ),
  );
  final response = await http
      // .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
      .get(Uri.parse('https://scrapbox.io/api/pages/neco3coffee-80957872'));
  print(response.body);
  // if (response.statusCode == 200) {
  //   print("success");
  // } else {
  //   print("failed");
  // }
}
