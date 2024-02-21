import 'dart:convert';
import 'package:dev_dictionary/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../models/word_model.dart';

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
    final response = await rootBundle.loadString(BASE_URL);
    var jsonResponse = json.decode(response);
    var data = WordModel.fromJson(jsonResponse);
    wordData(data.words);
    wordData.shuffle();

    return wordData;
  }

  var searhResults = <Word>[];
  var isSearching = false.obs;

  Future<List<Word>> searchData(String word) async {
    isSearching(true);
    update();
    searhResults.clear();
    if (word.isEmpty) {
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
    final response = await rootBundle.loadString(BASE_URL);
    var jsonResponse = json.decode(response);
    var data = WordModel.fromJson(jsonResponse);
    randomWords(data.words);
    update();
    return wordData;
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
      update();
    }
  }

  FlutterTts flutterTts = FlutterTts();
  var isSpeaking = false.obs;

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('bn-BD');
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    if (isSpeaking.value) {
      await flutterTts.stop();
      isSpeaking(false);
    } else {
      await flutterTts.speak(text);
      isSpeaking(true);
    }
    update();
  }
}
