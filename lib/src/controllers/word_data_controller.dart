import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../models/word_model.dart';
import '../services/network_service.dart';

class WordDataController extends GetxController {
  @override
  void onInit() {
    getShuffledWordData();
    getRandomWord();
    super.onInit();
  }

  final TextEditingController searchController = TextEditingController();

  var wordData = <Word>[].obs;

  Future<List<Word>> getShuffledWordData() async {
    final response = await NetworkService.get(BASE_URL);
    var jsonResponse = json.decode(response.body);
    var data = WordModel.fromJson(jsonResponse);
    wordData(data.words).shuffle();

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

  var randomWords = <Word>[].obs;

  Future<List<Word>> getRandomWord() async {
    final response = await NetworkService.get(BASE_URL);
    var jsonResponse = json.decode(response.body);
    var data = WordModel.fromJson(jsonResponse);
    randomWords(data.words);
    update();
    return wordData;
  }

  int itemsPerPage = 15;
  int currentPage = 1;

  List<Word> getPaginatedData(int currentPage) {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    // Make sure wordData is of type List<MyData>
    List<Word> typedWordData = wordData.cast<Word>();

    return typedWordData.sublist(startIndex, endIndex);
  }

  void loadNextPage() {
    int nextPage = currentPage + 1;

    if (nextPage * itemsPerPage <= wordData.length) {
      currentPage = nextPage;
      update();
    }
  }
}
