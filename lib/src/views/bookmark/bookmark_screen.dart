import 'package:dev_dictionary/src/controllers/word_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: GetBuilder<WordDataController>(
          init: WordDataController(),
          builder: (controller) {
            return Column(
              children: [
                controller.bookmarkedWords.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 250),
                          child: Text(
                            'No bookmarked words yet!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: controller.bookmarkedWords.length,
                            itemBuilder: (context, index) {
                              final word = controller.bookmarkedWords[index];
                              return ListTile(
                                onTap: () {},
                                title: Text(word.en.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                    )),
                                subtitle: Text(word.bn,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    )),
                                trailing: IconButton(
                                  onPressed: () {
                                    controller.deleteBookmark(word);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            })),
              ],
            );
          }),
    );
  }
}
