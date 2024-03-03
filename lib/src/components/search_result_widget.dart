import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:dev_dictionary/src/views/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/word_data_controller.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

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
                  fontFamily: 'Borno',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          wordDataController.isSearching
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Responsive.isDesktop(context)
                  ? CustomScrollView(
                      primary: true,
                      shrinkWrap: true,
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.all(16.0),
                          sliver: SliverGrid.count(
                            childAspectRatio: 4.0,
                            crossAxisCount: 3,
                            children: List.generate(
                                wordDataController.searchResults.length,
                                (index) {
                              final topic =
                                  wordDataController.searchResults[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.deepPurple[50],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      topic.en.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'Borno',
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    hoverColor: Colors.deepPurple[300],
                                    leading: const Icon(
                                      Icons.search,
                                      color: Colors.deepPurple,
                                      size: 40,
                                    ),
                                    subtitle: Text(topic.bn,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Borno',
                                          color: Colors.black45,
                                        )),
                                    onTap: () {
                                      context.go('/details/${topic.en}',
                                          extra: topic);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    )
                  : Responsive.isTablet(context)
                      ? CustomScrollView(
                          primary: true,
                          shrinkWrap: true,
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.all(16.0),
                              sliver: SliverGrid.count(
                                childAspectRatio: 4.0,
                                crossAxisCount: 2,
                                children: List.generate(
                                    wordDataController.searchResults.length,
                                    (index) {
                                  final topic =
                                      wordDataController.searchResults[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.deepPurple[50],
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          topic.en.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontFamily: 'Borno',
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        hoverColor: Colors.deepPurple[300],
                                        leading: const Icon(
                                          Icons.search,
                                          color: Colors.deepPurple,
                                          size: 40,
                                        ),
                                        subtitle: Text(topic.bn,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Borno',
                                              color: Colors.black45,
                                            )),
                                        onTap: () {
                                          context.go('/details/${topic.en}',
                                              extra: topic);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount:
                                  wordDataController.searchResults.length,
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
                                        color: Colors.deepPurple.shade300,
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
                                          wordDataController
                                              .searchResults[index].en
                                              .toUpperCase(),
                                          style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        subtitle: Text(
                                          wordDataController
                                              .searchResults[index].bn,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
