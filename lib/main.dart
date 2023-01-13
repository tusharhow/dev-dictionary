import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/views/devices/desktop_view.dart';
import 'package:dev_dictionary/src/views/devices/tablet_view.dart';
import 'package:dev_dictionary/src/views/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'src/views/devices/mobile_view.dart';

void main() async {
  setPathUrlStrategy();
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
      home: Responsive(
        mobile: MobileView(),
        tablet: const TabletView(),
        desktop: const DesktopView(),
      ),
    );
  }
}
