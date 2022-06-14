import 'dart:convert';

WordModel wordModelFromJson(String str) => WordModel.fromJson(json.decode(str));

String wordModelToJson(WordModel data) => json.encode(data.toJson());

class WordModel {
  WordModel({
    required this.words,
  });

  List<Word> words;

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
        words: List<Word>.from(json["words"].map((x) => Word.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "words": List<dynamic>.from(words.map((x) => x.toJson())),
      };
}

class Word {
  Word({
    required this.id,
    required this.en,
    required this.bn,
    required this.detail,
  });

  int id;
  String en;
  String bn;
  String detail;

  factory Word.fromJson(Map<String, dynamic> json) => Word(
        id: json["id"],
        en: json["en"],
        bn: json["bn"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "en": en,
        "bn": bn,
        "detail": detail,
      };
}
