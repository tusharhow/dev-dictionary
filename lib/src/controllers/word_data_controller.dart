import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/word_model.dart';

class WordDataController extends GetxController {
  @override
  void onInit() {
    getShuffledWordData();
    getRandomWord();
    fetchWordOfTheDay();
    super.onInit();
  }

  final TextEditingController searchController = TextEditingController();

  var wordData = <Word>[].obs;

  Future<List<Word>> getShuffledWordData() async {
    final baseUrl = dotenv.env['BASE_URL'];
    final response = await rootBundle.loadString(baseUrl!);
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
    final baseUrl = dotenv.env['BASE_URL'];
    final response = await rootBundle.loadString(baseUrl!);
    var jsonResponse = json.decode(response);
    var data = WordModel.fromJson(jsonResponse);
    randomWords(data.words);
    update();
    return wordData;
  }

  Future<Word> getWordByEn(String en) async {
    final baseUrl = dotenv.env['BASE_URL'];
    final response = await rootBundle.loadString(baseUrl!);
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
      update();
    }
  }

  final FlutterTts flutterTts = FlutterTts();
  var isSpeakingEnglish = false.obs;
  var isSpeakingBangla = false.obs;

  Future<void> speak(String text, bool isEnglish) async {
    await flutterTts.setLanguage(isEnglish ? 'en-US' : 'bn-BD');
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);

    flutterTts.setCompletionHandler(() {
      if (isEnglish) {
        isSpeakingEnglish.value = false;
        update();
      } else {
        isSpeakingBangla.value = false;
        update();
      }
    });

    await flutterTts.speak(text);

    if (isEnglish) {
      isSpeakingEnglish.value = true;
      update();
    } else {
      isSpeakingBangla.value = true;
      update();
    }
  }

  Future<void> stop(bool isEnglish) async {
    await flutterTts.stop();

    if (isEnglish) {
      isSpeakingEnglish.value = false;
    } else {
      isSpeakingBangla.value = false;
    }
    update();
  }

  int wordOfTheDay = 0; // Default value
  late DateTime lastFetched;

  Future<void> fetchWordOfTheDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    lastFetched = DateTime.parse(
        prefs.getString('lastFetched') ?? '1970-01-01T00:00:00Z');

    // Check if it's been more than a day since last fetch
    if (now.difference(lastFetched).inDays >= 1) {
      // Fetch new random number from the API
      int randomWord = (await getRandomWordd()) as int;

      wordOfTheDay = randomWord;
      update();

      // Save the new random number and update last fetched timestamp
      prefs.setInt('wordOfTheDay', randomWord);
      prefs.setString('lastFetched', now.toIso8601String());
    } else {
      // Use the existing random number

      wordOfTheDay = prefs.getInt('wordOfTheDay') ?? 0;
      update();
    }
  }

  Future<int> getRandomWordd() async {
    final baseUrl = dotenv.env['BASE_URL'];
    final response = await rootBundle.loadString(baseUrl!);
    var jsonResponse = json.decode(response);
    var data = WordModel.fromJson(jsonResponse);

    return data.words[Random().nextInt(data.words.length)].id;
  }
}
