import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/views/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor:
                controller.isDarkMode.value ? Colors.black : Colors.white,
            appBar: AppBar(
              title: const Text('Bookmark'),
            ),
            body: GetBuilder<WordDataController>(
                init: WordDataController(),
                builder: (controller) {
                  return Column(
                    children: [
                      controller.bookmarkedWords.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 250),
                                child: Text(
                                  'No bookmarked words yet!',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: controller.isDarkMode.value
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: controller.bookmarkedWords.length,
                                  itemBuilder: (context, index) {
                                    final word =
                                        controller.bookmarkedWords[index];
                                    return Card(
                                      color: controller.isDarkMode.value
                                          ? bgColor2
                                          : Colors.white,
                                      child: ListTile(
                                        onTap: () {
                                          Get.to(
                                              () => DetailScreen(word: word));
                                        },
                                        title: Text(word.en.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: controller.isDarkMode.value
                                                  ? Colors.white
                                                  : Colors.black,
                                            )),
                                        subtitle: Text(word.bn,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: controller.isDarkMode.value
                                                  ? Colors.white
                                                  : Colors.black,
                                            )),
                                        trailing: IconButton(
                                          onPressed: () {
                                            controller.deleteBookmark(word);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: controller.isDarkMode.value
                                                ? Colors.redAccent
                                                : Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                    ],
                  );
                }),
          );
        });
  }
}
