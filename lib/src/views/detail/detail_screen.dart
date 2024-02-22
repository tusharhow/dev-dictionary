import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/controllers/bookmark_controller.dart';
import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:dev_dictionary/src/models/bookmark_model.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

class MobileDetailsScreen extends StatelessWidget {
  MobileDetailsScreen({Key? key, required this.word}) : super(key: key);
  final Word word;
  
  final WordPropertyController wordPropertyController =
      Get.put(WordPropertyController());
  final WordDataController wordDataController = Get.put(WordDataController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                wordDataController.speak(word.detail, 'bn-BD');
              },
              backgroundColor: Colors.deepPurple,
              child: Icon(
                wordDataController.isSpeaking.value
                    ? Icons.stop
                    : Icons.volume_up,
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
              child: GetBuilder<BookmarkController>(
                  init: BookmarkController(),
                  builder: (controller) {
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          word.en.isNotEmpty
                                              ? word.en[0].toUpperCase() +
                                                  word.en.substring(1)
                                              : word.en,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            wordDataController.speak(
                                                word.en, 'en-US');
                                          },
                                          child: const Icon(
                                            Icons.volume_up,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          word.bn,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: defaultPadding),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            wordPropertyController
                                                .copyToClipboard(
                                                    word.bn, context);
                                          },
                                          child: Container(
                                            height: 45,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.deepPurple,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Icon(
                                              Icons.copy,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Icon(
                                              Icons.share,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (controller
                                                .isBookmarkSaved(word.id)) {
                                              controller
                                                  .removeBookmark(Bookmark(
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
                                          child: Obx(() => Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  color: controller
                                                          .isBookmarkSaved(
                                                              word.id)
                                                      ? Colors.redAccent
                                                      : Colors.deepPurple,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Icon(
                                                  controller.isBookmarkSaved(
                                                          word.id)
                                                      ? Icons.bookmark
                                                      : Icons.bookmark_border,
                                                  color: Colors.white,
                                                ),
                                              )),
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
                            child: Container(
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
                                    fontSize:
                                        wordPropertyController.fontSize.value,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
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
