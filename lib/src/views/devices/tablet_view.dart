import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/components/list_item_view.dart';
import 'package:dev_dictionary/src/components/search_bar_widget.dart';
import 'package:dev_dictionary/src/components/search_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/footer_widget.dart';
import '../../components/top_header_widget.dart';
import '../../controllers/word_data_controller.dart';

class TabletView extends StatelessWidget {
  const TabletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:
            Consumer<WordDataController>(builder: (context, controller, child) {
          return Column(
            children: [
              const TopHeaderDesktop(),
              const SizedBox(height: 30),
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
              const SizedBox(height: 20),
              SearchBarWidget(
                textEditingController: controller.searchController,
                controller: controller,
              ),
              const SizedBox(height: 60),
              controller.searchResults.isNotEmpty
                  ? const SearchResultWidget()
                  : ListItemView(
                      future: controller.getShuffledWordData(),
                      crossAxisCount: 2,
                      itemCount: 15,
                      isMobile: false,
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
