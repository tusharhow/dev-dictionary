import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class BigScreenDetailsPage extends StatelessWidget {
  const BigScreenDetailsPage({Key? key, required this.word}) : super(key: key);
  final Word word;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor:
                controller.isDarkMode.value ? bgColor : Colors.white,
            appBar: AppBar(
                backgroundColor:
                    controller.isDarkMode.value ? bgColor : Colors.white,
                elevation: 0,
                title: Text(
                  word.en,
                  style: TextStyle(
                    color: controller.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: controller.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                  ),
                )),
            body: SingleChildScrollView(
              child: GetBuilder<WordDataController>(
                  init: WordDataController(),
                  builder: (controller) {
                    return Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Column(
                          children: [
                            const SizedBox(height: defaultPadding),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: 180,
                                decoration: BoxDecoration(
                                  color: bgColor2,
                                  borderRadius: BorderRadius.circular(10),
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
                                            onTap: () async {
                                              await Clipboard.setData(
                                                      ClipboardData(
                                                          text: word.detail))
                                                  .then((value) => ScaffoldMessenger
                                                          .of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Copied to Clipboard'))));
                                            },
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .indigoAccent.shade100,
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
                                                color: Colors
                                                    .indigoAccent.shade100,
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
                                              controller.addBookmark(word).then(
                                                    (value) =>
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Bookmark Added'),
                                                      ),
                                                    ),
                                                  );
                                            },
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: controller
                                                        .isBookmarked.value
                                                    ? Colors.red.shade100
                                                    : Colors
                                                        .indigoAccent.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.bookmark,
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
                                  color: bgColor2,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    word.detail,
                                    style: TextStyle(
                                      fontSize: controller.fontSize.value,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20 * 3),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding),
                                child: Text(
                                  'Related Words',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: controller.isDarkMode.value
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // SizedBox(
                            //   height: 200,
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: controller.relatedWords.length,
                            //     itemBuilder: (context, index) {
                            //       return GestureDetector(
                            //         onTap: () {},
                            //         child: Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: defaultPadding),
                            //           child: Container(
                            //             width: 150,
                            //             decoration: BoxDecoration(
                            //               color: bgColor2,
                            //               borderRadius:
                            //                   BorderRadius.circular(10),
                            //             ),
                            //             child: Padding(
                            //               padding: const EdgeInsets.all(20.0),
                            //               child: Column(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.center,
                            //                 children: [
                            //                   Text(
                            //                     controller
                            //                         .relatedWords[index].bn,
                            //                     style: const TextStyle(
                            //                       fontSize: 20,
                            //                       color: Colors.red,
                            //                     ),
                            //                   ),
                            //                   const SizedBox(height: 10),
                            //                   Text(
                            //                     controller
                            //                         .relatedWords[index].en,
                            //                     style: const TextStyle(
                            //                       fontSize: 15,
                            //                       color: Colors.red,
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
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
