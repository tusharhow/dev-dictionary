import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../models/word_model.dart';
import '../services/network_service.dart';

class WordDataController extends GetxController {
  @override
  void onInit() {
    getShuffledWordData();
    getBookmarkedWords();
    getFontSize();
    getTheme();
    super.onInit();
  }

  final TextEditingController searchController = TextEditingController();

  var wordData = <Word>[].obs;

  Future<List<Word>> getShuffledWordData() async {
    final response = await NetworkService.get(BASE_URL);
    var jsonResponse = json.decode(response.body);
    var data = WordModel.fromJson(jsonResponse);
    wordData(data.words);
    update();
    return wordData;
  }

  var searhResults = <Word>[];
  var isSearching = false.obs;

  Future<List<Word>> searchData(String word) async {
    isSearching(true);
    update();
    searhResults.clear();
    if (word.isEmpty) {
      update();
      return searhResults;
    }

    for (var wordDetail in wordData) {
      if (wordDetail.bn.toLowerCase().contains(word.toLowerCase()) ||
          wordDetail.en.toLowerCase().contains(word.toLowerCase()) ||
          wordDetail.detail.toLowerCase().contains(word.toLowerCase())) {
        searhResults.remove(wordDetail);
        searhResults.add(wordDetail);
      }
    }
    isSearching(false);
    update();
    return searhResults;
  }

  // related by first 3 letters
  var relatedWords = <Word>[].obs;
  Future<List<Word>> getRelatedWords(String word) async {
    relatedWords.clear();
    for (var wordDetail in wordData) {
      if (wordDetail.bn.toLowerCase().contains(word.toLowerCase()) ||
          wordDetail.en.toLowerCase().contains(word.toLowerCase()) ||
          wordDetail.detail.toLowerCase().contains(word.toLowerCase())) {
        relatedWords.remove(wordDetail);
        relatedWords.add(wordDetail);
      }
    }
    update();
    return relatedWords;
  }

  // add bookmark and save to local storage
  var bookmarkedWords = <Word>[].obs;
  var isBookmarked = false.obs;

  Future<void> addBookmark(Word word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bookmarkedWords.add(word);
    prefs.setStringList('bookmarkedWords',
        [for (var word in bookmarkedWords) json.encode(word.toJson())]);
    isBookmarked(true);
    update();

    update();
  }

  Future<List<Word>> getBookmarkedWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bookmarkedWordsList = prefs.getStringList('bookmarkedWords');
    bookmarkedWords.clear();
    if (bookmarkedWordsList != null) {
      bookmarkedWordsList.forEach((element) {
        bookmarkedWords.add(Word.fromJson(json.decode(element)));
      });
    }

    update();
    return bookmarkedWords;
  }

  Future<void> deleteBookmark(Word word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bookmarkedWords.remove(word);
    prefs.setStringList('bookmarkedWords',
        [for (var word in bookmarkedWords) json.encode(word.toJson())]);
    isBookmarked(false);
    update();
  }

  // change theme and save to local storage
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

// get theme from local storage
  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode(prefs.getBool('isDarkMode') ?? false);
    Get.changeTheme(isDarkMode.value
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true));
    update();
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

// 'https://github.com/tusharhow/dev-dictionary'

  Future urlLauncher(String uri) async {
    if (await canLaunchUrl(Uri.parse(uri))) {
      await launchUrl(Uri.parse(uri));
    } else {
      throw 'Could not launch $uri';
    }
  }

  // copy to clipboard
  Future<void> copyToClipboard(String text, context) async {
    await Clipboard.setData(ClipboardData(text: text)).then((value) =>
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Copied to Clipboard'))));
  }
}
