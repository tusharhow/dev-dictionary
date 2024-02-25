import 'package:dev_dictionary/src/controllers/bookmark_controller.dart';
import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:dev_dictionary/src/models/bookmark_model.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:dev_dictionary/src/views/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class BigScreenDetailsPage extends StatelessWidget {
  const BigScreenDetailsPage({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkController>(builder: (c, controller, child) {
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
                        Consumer<WordPropertyController>(
                            builder: (context, wordPropertyController, child) {
                          return Row(
                            children: [
                              Slider(
                                value: wordPropertyController.fontSize,
                                onChanged: (value) {
                                  wordPropertyController.changeFontSize(value);
                                },
                                min: 10,
                                max: 40,
                              ),
                              Text(wordPropertyController.fontSize
                                  .toStringAsFixed(0))
                            ],
                          );
                        }),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      Consumer<WordPropertyController>(
                          builder: (context, wordPropertyController, child) {
                        return TextButton(
                            onPressed: () {
                              wordPropertyController.changeFontSize(
                                  wordPropertyController.fontSize);
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'));
                      }),
                    ],
                  );
                });
          },
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.format_size, color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Consumer<BookmarkController>(
              builder: (context, controller, child) {
            return Center(
              child: SizedBox(
                width: Responsive.isDesktop(context)
                    ? MediaQuery.of(context).size.width / 1.7
                    : double.infinity,
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
                          child: Consumer<WordPropertyController>(builder:
                              (context, wordPropertyController, child) {
                            return IconButton(
                              onPressed: () {
                                wordPropertyController.stop(true);
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            );
                          }),
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  Consumer<WordPropertyController>(builder:
                                      (context, wordPropertyController, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (wordPropertyController
                                            .isSpeakingEnglish) {
                                          wordPropertyController.stop(true);
                                        } else {
                                          wordPropertyController.speak(
                                              word.en, true);
                                        }
                                      },
                                      child: Icon(
                                        wordPropertyController.isSpeakingEnglish
                                            ? Icons.stop
                                            : Icons.volume_up,
                                        color: Colors.white,
                                      ),
                                    );
                                  }),
                                  const SizedBox(width: defaultPadding),
                                  Text(
                                    word.bn,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontFamily: 'Borno',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: defaultPadding),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Consumer<WordPropertyController>(builder:
                                      (context, wordPropertyController, child) {
                                    return GestureDetector(
                                      onTap: () {
                                        wordPropertyController.copyToClipboard(
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
                                    );
                                  }),
                                  const SizedBox(width: defaultPadding * 4),
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: defaultPadding * 4),
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
                                        color:
                                            controller.isBookmarkSaved(word.id)
                                                ? Colors.red
                                                : Colors.green.shade300,
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
                          child: Consumer<WordPropertyController>(builder:
                              (context, wordPropertyController, child) {
                            return Text(
                              word.detail,
                              style: TextStyle(
                                fontSize: wordPropertyController.fontSize,
                                color: Colors.white,
                                fontFamily: 'Borno',
                              ),
                              textAlign: TextAlign.center,
                            );
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20 * 3),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: Text(
                          'Related Words',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Consumer<WordDataController>(
                        builder: (context, wordDataController, child) {
                      return FutureBuilder<List<Word>>(
                          future: wordDataController.getRandomWord(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SizedBox(
                                height: 170,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final word =
                                        wordDataController.randomWords[index];

                                    return GestureDetector(
                                      onTap: () {
                                        context.go(
                                            '/${AppRouteConstants.detailsRouteName}/${word.en}',
                                            extra: word);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurple[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors.white,
                                                  child: Text(
                                                    word.en.isNotEmpty
                                                        ? word.en[0]
                                                            .toUpperCase()
                                                        : word.en,
                                                    style: const TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.deepPurple,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  word.en.toUpperCase(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  word.bn,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Borno',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          });
                    }),
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
