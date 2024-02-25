import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/controllers/bookmark_controller.dart';
import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:dev_dictionary/src/models/bookmark_model.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';

class MobileDetailsScreen extends StatelessWidget {
  const MobileDetailsScreen({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    return Consumer<WordPropertyController>(
        builder: (context, wordPropertyController, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (wordPropertyController.isSpeakingBangla) {
              wordPropertyController.stop(false);
            } else {
              wordPropertyController.speak(word.bn, false);
            }
          },
          backgroundColor: Colors.deepPurple,
          child: Icon(
            wordPropertyController.isSpeakingBangla ? Icons.stop : Icons.volume_up,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(10),
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Consumer<BookmarkController>(
              builder: (context, controller, child) {
            return Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  word.en.isNotEmpty
                                      ? word.en[0].toUpperCase() +
                                          word.en.substring(1)
                                      : word.en,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    if (wordPropertyController.isSpeakingEnglish) {
                                      wordPropertyController.stop(true);
                                    } else {
                                      wordPropertyController.speak(word.en, true);
                                    }
                                  },
                                  child: Icon(
                                    wordPropertyController.isSpeakingEnglish
                                        ? Icons.stop
                                        : Icons.volume_up,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  word.bn,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: defaultPadding),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Consumer<WordPropertyController>(builder:
                                    (context, wordPropertyController, c) {
                                  return GestureDetector(
                                    onTap: () {
                                      wordPropertyController.copyToClipboard(
                                          word.bn, context);
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }),
                                GestureDetector(
                                  onTap: () {
                                    FlutterShare.share(
                                      title: word.en,
                                      text: word.detail,
                                      chooserTitle: 'Share via',
                                    );
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.isBookmarkSaved(word.id)) {
                                      controller.removeBookmark(Bookmark(
                                        id: word.id,
                                        en: word.en,
                                        bn: word.bn,
                                        detail: word.detail,
                                      ));
                                    } else {
                                      controller.addBookmark(Bookmark(
                                        id: word.id,
                                        en: word.en,
                                        bn: word.bn,
                                        detail: word.detail,
                                      ));
                                    }
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: controller.isBookmarkSaved(word.id)
                                          ? Colors.redAccent
                                          : Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      controller.isBookmarkSaved(word.id)
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<WordPropertyController>(
                        builder: (context, wordPropertyController, c) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 16),
                          child: Text(
                            word.detail,
                            style: TextStyle(
                              fontSize: wordPropertyController.fontSize,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}
