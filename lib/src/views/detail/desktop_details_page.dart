import 'package:dev_dictionary/src/controllers/bookmark_controller.dart';
import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:dev_dictionary/src/models/bookmark_model.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../constants.dart';

class BigScreenDetailsPage extends StatelessWidget {
  BigScreenDetailsPage({Key? key, required this.word}) : super(key: key);
  final Word word;

  final WordDataController wordDataController = Get.put(WordDataController());
  final WordPropertyController wordPropertyController =
      Get.put(WordPropertyController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarkController>(
        init: BookmarkController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Change Font Size'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Obx(() => Slider(
                                      value:
                                          wordPropertyController.fontSize.value,
                                      onChanged: (value) {
                                        wordPropertyController
                                            .changeFontSize(value);
                                      },
                                      min: 10,
                                      max: 40,
                                    )),
                                Obx(() => Text(wordPropertyController
                                    .fontSize.value
                                    .toStringAsFixed(0))),
                              ],
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () {
                                wordPropertyController.changeFontSize(
                                    wordPropertyController.fontSize.value);
                                Navigator.pop(context);
                              },
                              child: const Text('Ok')),
                        ],
                      );
                    });
              },
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.format_size, color: Colors.white),
            ),
            body: SingleChildScrollView(
              child: GetBuilder<BookmarkController>(
                  init: BookmarkController(),
                  builder: (controller) {
                    return Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Column(
                          children: [
                            const SizedBox(height: defaultPadding),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 50,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: defaultPadding),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultPadding),
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
                                              fontSize: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: defaultPadding),
                                          GestureDetector(
                                            onTap: () {
                                              if (wordDataController
                                                  .isSpeakingEnglish.value) {
                                                wordDataController.stop(true);
                                              } else {
                                                wordDataController.speak(
                                                    word.en, true);
                                              }
                                            },
                                            child: Obx(() => Icon(
                                                  wordDataController
                                                          .isSpeakingEnglish
                                                          .value
                                                      ? Icons.stop
                                                      : Icons.volume_up,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          const SizedBox(width: defaultPadding),
                                          Text(
                                            word.bn,
                                            style: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              wordPropertyController
                                                  .copyToClipboard(
                                                      word.detail, context);
                                            },
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: Colors.green.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.copy,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                              width: defaultPadding * 4),
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
                                                color: Colors.green.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.share,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                              width: defaultPadding * 4),
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
                                                        ? Colors.red
                                                        : Colors.green.shade300,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                  color: Colors.deepPurple[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Obx(() => Text(
                                        word.detail,
                                        style: TextStyle(
                                          fontSize: wordPropertyController
                                              .fontSize.value,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20 * 3),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding),
                                child: Text(
                                  'Related Words',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 400,
                              child: FutureBuilder<List<Word>>(
                                  future: wordDataController.getRandomWord(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          final word = wordDataController
                                              .randomWords[index];

                                          return GestureDetector(
                                            onTap: () {
                                              context.go(
                                                  '/${AppRouteConstants.detailsRouteName}/${word.en}',
                                                  extra: word);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              child: Container(
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple[200],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Center(
                                                    child: Text(
                                                      word.en.toUpperCase(),
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
