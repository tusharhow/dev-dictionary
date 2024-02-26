import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/components/list_item_view.dart';
import 'package:dev_dictionary/src/components/pagination_row.dart';
import 'package:dev_dictionary/src/components/search_bar_widget.dart';
import 'package:dev_dictionary/src/components/search_result_widget.dart';
import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/footer_widget.dart';
import '../../components/top_header_widget.dart';
import '../../controllers/word_data_controller.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

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
                    SearchBarWidget(
                      textEditingController: wordController.searchController,
                      controller: wordController,
                    ),
                    const SizedBox(height: 80),
                    wordController.searchResults.isNotEmpty
                        ? const SearchResultWidget()
                        : wordController.wordData.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListItemView(
                                future: wordController.getWordData(),
                                controller: wordController,
                                crossAxisCount: 3,
                                itemCount: 15,
                                isMobile: false,
                              ),
                    const SizedBox(height: 20),
                    if (wordController.searchResults.isEmpty)
                      wordController.wordData.isEmpty
                          ? const SizedBox()
                          : PaginationRow(
                              wordController: wordController,
                              wordPropertyController: WordPropertyController()),
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
