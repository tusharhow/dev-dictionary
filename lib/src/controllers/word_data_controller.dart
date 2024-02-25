import 'dart:async';
import 'dart:convert';
import 'package:dev_dictionary/src/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/word_model.dart';

class WordDataController extends ChangeNotifier {
  WordDataController() {
    getShuffledWordData();
    getRandomWord();
  }

  final TextEditingController searchController = TextEditingController();

  var wordData = <Word>[];

  Future<List<Word>> getShuffledWordData() async {
    final response = await rootBundle.loadString(Config.BASE_URL);
    var jsonResponse = json.decode(response);
    var data = WordModel.fromJson(jsonResponse);
    wordData = data.words;
    wordData.shuffle();
    return wordData;
  }

  var searchResults = <Word>[];
  var isSearching = false;

  Future<List<Word>> searchData(String word) async {
    isSearching = true;
    searchResults.clear();
    notifyListeners();

    if (word.isEmpty) {
      return searchResults;
    }

    for (var wordDetail in wordData) {
      if (wordDetail.bn.toLowerCase().contains(word.toLowerCase()) ||
          wordDetail.en.toLowerCase().contains(word.toLowerCase()) ||
          wordDetail.detail.toLowerCase().contains(word.toLowerCase())) {
        searchResults.remove(wordDetail);
        searchResults.add(wordDetail);
      }
    }
    isSearching = false;
    notifyListeners();
    return searchResults;
  }

  void clearSearchResults() {
    searchResults.clear();
    searchController.clear();
    notifyListeners();
  }

  var randomWords = <Word>[];

  Future<List<Word>> getRandomWord() async {
    final response = await rootBundle.loadString(Config.BASE_URL);
    var jsonResponse = json.decode(response);
    var data = WordModel.fromJson(jsonResponse);
    randomWords = data.words;
    notifyListeners();
    return randomWords;
  }

  Future<Word> getWordByEn(String en) async {
    final response = await rootBundle.loadString(Config.BASE_URL);
    var jsonResponse = json.decode(response);
    var data = WordModel.fromJson(jsonResponse);
    var word = data.words.firstWhere((element) => element.en == en);
    return word;
  }

  int itemsPerPage = 15;
  int currentPage = 1;

  List<dynamic> getPaginatedData() {
    final startIndex = (currentPage - 1) * itemsPerPage;
    var endIndex = startIndex + itemsPerPage;

    endIndex = endIndex.clamp(0, wordData.length);

    return wordData.sublist(startIndex, endIndex);
  }

  void loadNextPage() {
    int nextPage = currentPage + 1;

    if (nextPage * itemsPerPage <= wordData.length) {
      currentPage = nextPage;
      notifyListeners();
    }
  }
}
