import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/word_data_controller.dart';

class HomeListViewItem extends StatelessWidget {
  HomeListViewItem({Key? key}) : super(key: key);

  final WordPropertyController wordPropertyController =
      Get.put(WordPropertyController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return FutureBuilder<List<Word>>(
              future: controller.getShuffledWordData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 25,
                      itemBuilder: (context, index) {
                        var word = snapshot.data![index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              context.go('/details/${word.en}', extra: word);
                            },
                            child: Card(
                              elevation: 2,
                              child: SizedBox(
                                height: 70,
                                child: Center(
                                  child: Text(
                                    word.en.toUpperCase(),
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      // color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              });
        });
  }
}
