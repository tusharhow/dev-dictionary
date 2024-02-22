import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await loadTheme();
  }

  var isDarkMode = false.obs;

  void toggleDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.toggle();
    Get.changeTheme(isDarkMode.value
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true));
    prefs.setBool('isDarkMode', isDarkMode.value);
    update();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode(prefs.getBool('isDarkMode') ?? false);
    Get.changeTheme(isDarkMode.value
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true));
    update();
  }
}
