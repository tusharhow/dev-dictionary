import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class WordPropertyController extends GetxController {
  @override
  void onInit() {
    getFontSize();
    super.onInit();
  }

  // change font size and save to local storage
  var fontSize = 16.0.obs;

  Future<void> changeFontSize(double size) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fontSize(size);
    prefs.setDouble('fontSize', fontSize.value);
    update();
  }

  // get font size from local storage
  Future<void> getFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fontSize(prefs.getDouble('fontSize') ?? 16.0);
    update();
  }

  Future urlLauncher(String uri) async {
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      throw 'Could not launch $uri';
    }
  }

  // copy to clipboard
  Future<void> copyToClipboard(String text, context) async {
    await Clipboard.setData(ClipboardData(text: text)).then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Copied to clipboard"),
              backgroundColor: Colors.deepPurple,
            )));
  }
}
