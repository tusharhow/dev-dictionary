import 'dart:async';
import 'dart:convert';
import 'package:dev_dictionary/src/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../models/word_model.dart';

class WordDataController extends ChangeNotifier {
  WordDataController() {
    getWordData();
    getRandomWord();

    scrollController.addListener(onScroll);
  }

  final TextEditingController searchController = TextEditingController();

  var wordData = <Word>[];

  Future<List<Word>> getWordData() async {
    final response = await rootBundle.loadString(Config.BASE_URL);
    var jsonResponse = json.decode(response);
    var data = WordModel.fromJson(jsonResponse);
    wordData = data.words;
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

    return wordData.sublist(0, endIndex);
  }

  void nextPage(BuildContext context) {
    if (currentPage < (wordData.length / itemsPerPage).ceil()) {
      currentPage++;
      notifyListeners();
      if (currentPage == 1) {
        context.go('/');
      } else {
        context.go('/?page=$currentPage');
      }
    }
  }

  void previousPage(BuildContext context) {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
      if (currentPage == 1) {
        context.go('/');
      } else {
        context.go('/?page=$currentPage');
      }
    }
  }

  final scrollController = ScrollController();
  bool isLoading = false;

  void onScroll() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      lazyLoad();
    }
  }

  void lazyLoad() {
    isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () {
      if (currentPage < (wordData.length / itemsPerPage).ceil()) {
        getPaginatedData();
        currentPage++;
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
