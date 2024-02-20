class Bookmark {
  int id;
  String en;
  String bn;
  String detail;

  Bookmark({
    required this.id,
    required this.en,
    required this.bn,
    required this.detail,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'en': en,
      'bn': bn,
      'detail': detail,
    };
  }

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'],
      en: json['en'],
      bn: json['bn'],
      detail: json['detail'],
    );
  }
}
