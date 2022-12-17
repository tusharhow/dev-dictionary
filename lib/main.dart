import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/views/home_page/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Get.put(WordDataController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme.isDarkMode.value
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      home: MyHomePage(),
    );
  }
}
