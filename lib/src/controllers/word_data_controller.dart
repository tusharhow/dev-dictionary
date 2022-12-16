import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../models/word_model.dart';

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

  var isLoading = false.obs;
  var wordData = <Word>[];

  Future<List<Word>> getShuffledWordData() async {
    isLoading(true);
    update();

    final response = await http.get(Uri.parse(BASE_URL));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = WordModel.fromJson(jsonResponse);
      var wordList = data.words;

      wordData = wordList;
      update();
    } else {
      throw Exception('Failed to load data');
    }

    isLoading(false);
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

  Future<void> changeTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.toggle();
    prefs.setBool('isDarkMode', isDarkMode.value);
    print(isDarkMode.value);
    update();
  }

  // get theme from local storage
  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode(prefs.getBool('isDarkMode') ?? false);
    print(isDarkMode.value);
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
}
