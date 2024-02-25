import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController() {
    loadTheme();
  }

  bool isDarkMode = false;

  void toggleDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode = !isDarkMode;
    prefs.setBool('isDarkMode', isDarkMode);
    notifyListeners();
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }
}
