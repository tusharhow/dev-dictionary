import 'package:dev_dictionary/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/homepage.dart';

void main() {
  runApp(const MyApp());

}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: bgColor,
      ),
      home: const MyHomePage(),
    );
  }
}
