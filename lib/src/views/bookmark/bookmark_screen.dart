import 'package:dev_dictionary/src/controllers/bookmark_controller.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:dev_dictionary/src/views/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookMarkScreen extends StatelessWidget {
  BookMarkScreen({Key? key}) : super(key: key);
  final BookmarkController controller = Get.put(BookmarkController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.bookmarks.isEmpty) {
                return const Center(
                  child: Text(
                    'No bookmarked words',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: controller.bookmarks.length,
                  itemBuilder: (context, index) {
                    var word = controller.bookmarks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                word: Word(
                                  en: word.en,
                                  bn: word.bn,
                                  id: word.id,
                                  detail: word.detail,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                              word.en.toUpperCase(),
                            ),
                            subtitle: Text(
                              word.bn,
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                controller.removeBookmark(word);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
