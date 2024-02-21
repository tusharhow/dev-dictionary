import 'package:dev_dictionary/src/views/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/word_data_controller.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (wordDataController) {
          return Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 16),
                  child: Text(
                    'সার্চ রেজাল্ট সমূহ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              wordDataController.isSearching.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: wordDataController.searhResults.length,
                          itemBuilder: (BuildContext context, index) {
                            if (wordDataController.isSearching.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[600],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            word: wordDataController
                                                .searhResults[index],
                                          ),
                                        ),
                                      );
                                    },
                                    title: Text(
                                      wordDataController.searhResults[index].en,
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      wordDataController.searhResults[index].bn,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white54,
                                      ),
                                      maxLines: 2,
                                    ),
                                    leading: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                    )
            ],
          );
        });
  }
}
