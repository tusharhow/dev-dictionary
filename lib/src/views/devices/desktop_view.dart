import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../components/footer_widget.dart';
import '../../components/top_header_widget.dart';
import '../../controllers/word_data_controller.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<WordDataController>(
            builder: (context, wordController, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200),
                child: Column(
                  children: [
                    const TopHeaderDesktop(),
                    const SizedBox(height: 50),
                    const Center(
                      child: Text(
                        AppConstants.appNameBangali,
                        style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Borno',
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      AppConstants.appSlugBengali,
                      style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'Borno',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        elevation: 5,
                        child: SizedBox(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 3,
                          child: TextFormField(
                            onChanged: (String query) {
                              if (query.isNotEmpty) {
                                wordController.searchData(query.trim());
                              } else {
                                 wordController.clearSearchResults();
                              }
                            },
                            controller: wordController.searchController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              hintText: AppConstants.textFieldHint,
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              suffixIcon:
                                  wordController.searchController.text.isEmpty
                                      ? null
                                      : IconButton(
                                          onPressed: () {
                                            wordController.clearSearchResults();
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                          ),
                                        ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    wordController.searchResults.isNotEmpty
                        ? Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'সার্চ রেজাল্ট সমূহ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Borno',
                                    ),
                                  ),
                                ),
                              ),
                              CustomScrollView(
                                primary: false,
                                shrinkWrap: true,
                                slivers: [
                                  SliverPadding(
                                    padding: const EdgeInsets.all(16.0),
                                    sliver: SliverGrid.count(
                                      childAspectRatio: 4.0,
                                      crossAxisCount: 3,
                                      children: List.generate(
                                          wordController.searchResults.length,
                                          (index) {
                                        final topic =
                                            wordController.searchResults[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                              hoverColor:
                                                  Colors.deepPurple[300],
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
                                                context.go(
                                                    '/details/${topic.en}',
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
                              ),
                            ],
                          )
                        : wordController.wordData.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    wordController.getPaginatedData().length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 3.5,
                                ),
                                itemBuilder: (context, index) {
                                  final topic =
                                      wordController.getPaginatedData()[index];

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 3,
                                      child: ListTile(
                                        title: Center(
                                          child: Text(
                                            topic.en.toUpperCase(),
                                            style: GoogleFonts.inter(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          context.go(
                                              '/${AppRouteConstants.detailsRouteName}/${topic.en}',
                                              extra: topic);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                    const SizedBox(height: 20),
                    if (wordController.searchResults.isEmpty)
                      wordController.wordData.isEmpty
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (wordController.currentPage > 1) {
                                      wordController.currentPage--;

                                      if (wordController.currentPage == 1) {
                                        context.go(
                                            AppRouteConstants.homeRouteName);
                                      } else {
                                        context.go(
                                            '/?page=${wordController.currentPage}');
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_back_ios),
                                ),
                                Text(
                                  'Page ${wordController.currentPage}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Borno',
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (wordController.currentPage <
                                        (wordController.wordData.length /
                                                wordController.itemsPerPage)
                                            .ceil()) {
                                      wordController.currentPage++;

                                      if (wordController.currentPage == 1) {
                                        context.go('/');
                                      } else {
                                        context.go(
                                            '/?page=${wordController.currentPage}');
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios),
                                ),
                              ],
                            ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              const FooterWidget(),
            ],
          );
        }),
      ),
    );
  }
}
