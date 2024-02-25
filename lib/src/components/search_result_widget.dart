import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/word_data_controller.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WordDataController>(
        builder: (context, wordDataController, child) {
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
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          wordDataController.isSearching
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: wordDataController.searchResults.length,
                      itemBuilder: (BuildContext context, index) {
                        if (wordDataController.isSearching) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                onTap: () {
                                  context.go(
                                      '/${AppRouteConstants.detailsRouteName}/${wordDataController.searchResults[index].en}',
                                      extra: wordDataController
                                          .searchResults[index]);
                                },
                                title: Text(
                                  wordDataController.searchResults[index].en
                                      .toUpperCase(),
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  wordDataController.searchResults[index].bn,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white54,
                                    fontFamily: 'Borno',
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
