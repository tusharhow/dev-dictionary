import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class WordPropertyController extends ChangeNotifier {
  WordPropertyController() {
    getFontSize();
  }

  // change font size and save to local storage
  var fontSize = 16.0;

  Future<void> changeFontSize(double size) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fontSize = size;
    prefs.setDouble('fontSize', fontSize);
    notifyListeners();
  }

  // get font size from local storage
  Future<void> getFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fontSize = prefs.getDouble('fontSize') ?? 16.0;
    notifyListeners();
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

  final FlutterTts flutterTts = FlutterTts();
  var isSpeakingEnglish = false;
  var isSpeakingBangla = false;

  Future<void> speak(String text, bool isEnglish) async {
    await flutterTts.setLanguage(isEnglish ? 'en-US' : 'bn-BD');
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);

    flutterTts.setCompletionHandler(() {
      if (isEnglish) {
        isSpeakingEnglish = false;
        notifyListeners();
      } else {
        isSpeakingBangla = false;
        notifyListeners();
      }
    });

    await flutterTts.speak(text);

    if (isEnglish) {
      isSpeakingEnglish = true;
      notifyListeners();
    } else {
      isSpeakingBangla = true;
      notifyListeners();
    }
  }

  Future<void> stop(bool isEnglish) async {
    await flutterTts.stop();

    if (isEnglish) {
      isSpeakingEnglish = false;
    } else {
      isSpeakingBangla = false;
    }
    notifyListeners();
  }
}
