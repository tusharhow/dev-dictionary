import 'dart:convert';
import 'package:dev_dictionary/src/models/bookmark_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkController extends GetxController {
  @override
  void onInit() {
    loadBookmarks();
    super.onInit();
  }

  var bookmarks = <Bookmark>[].obs;

  bool isBookmarkSaved(int id) {
    return bookmarks.any((bookmark) => bookmark.id == id);
  }

  Future<void> addBookmark(Bookmark bookmark) async {
    bookmarks.add(bookmark);
    await saveBookmarks();
  }

  Future<void> removeBookmark(Bookmark bookmark) async {
    bookmarks.removeWhere((b) => b.id == bookmark.id);
    await saveBookmarks();
  }

  Future<void> saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedBookmarks = bookmarks.map((b) => b.toJson()).toList();
    await prefs.setStringList(
        'bookmarks',
        encodedBookmarks.map((e) {
          return json.encode(e);
        }).toList());
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedBookmarks = prefs.getStringList('bookmarks');
    if (encodedBookmarks != null) {
      bookmarks.assignAll(encodedBookmarks
          .map((e) => json.decode(e))
          .map((e) => Bookmark.fromJson(e))
          .toList());
    }
    update();
    print(bookmarks.length);
  }
}
