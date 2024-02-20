import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/controllers/bookmark_controller.dart';
import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:dev_dictionary/src/models/bookmark_model.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key, required this.word}) : super(key: key);
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
            backgroundColor: bgColor,
            appBar: AppBar(
                backgroundColor: bgColor,
                elevation: 0,
                title: Text(
                  word.en,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                )),
            body: SingleChildScrollView(
              child: GetBuilder<BookmarkController>(
                  init: BookmarkController(),
                  builder: (controller) {
                    return Column(
                      children: [
                        const SizedBox(height: defaultPadding),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: BoxDecoration(
                              color: bgColor2,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: defaultPadding),
                                    child: Text(
                                      word.bn,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
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
                                            color: Colors.indigoAccent.shade100,
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
                                            color: Colors.indigoAccent.shade100,
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
                                        child: Obx(() => Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color:
                                                    controller.isBookmarkSaved(
                                                            word.id)
                                                        ? Colors.redAccent
                                                        : Colors.indigoAccent
                                                            .shade100,
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
                        const SizedBox(height: 20),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: BoxDecoration(
                              color: bgColor2,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 20),
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
                      ],
                    );
                  }),
            ),
          );
        });
  }
}
