import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../controllers/word_data_controller.dart';
import '../views/detail/detail_screen.dart';

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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    word: word,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: bgColor2,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  word.en.toUpperCase(),
                                  style: GoogleFonts.inter(
                                    fontSize:
                                        wordPropertyController.fontSize.value,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
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
