import 'dart:convert';
import 'package:dev_dictionary/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WordController extends GetxController {
  var url =
      'https://raw.githubusercontent.com/tusharhow/dev-dictionary-data/main/dev_dictionary_data.json';
  var isLoading = false.obs;
// search word from json file
  var filteredTitle;
  var filteredDescription;
  getData(String word) async {
    isLoading.value = true;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = WordModel.fromJson(jsonResponse);
      var wordList = data.words;
      var wordData = wordList
          .where((element) => element.en.toLowerCase() == word.toLowerCase())
          .toList();
      update();
      if (wordData.isNotEmpty) {
        isLoading.value = false;
        print(wordData[0].bn);
        filteredTitle = wordData[0].bn;
        filteredDescription = wordData[0].detail;
        print(filteredTitle);
        update();
      } else {
        isLoading.value = false;
        update();
      }
    }
  }
}
