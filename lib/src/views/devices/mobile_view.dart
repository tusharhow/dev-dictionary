import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/components/list_item_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../components/drawer_widget.dart';
import '../../components/search_bar_widget.dart';
import '../../components/search_result_widget.dart';
import '../../controllers/word_data_controller.dart';

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WordDataController>(builder: (context, controller, child) {
      return SafeArea(
        child: Scaffold(
          drawer: const DrawerWidget(),
          body: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'ডেভ',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontFamily: 'Borno',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'ডিকশনারি',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Borno',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  AppConstants.appSlug,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SearchBarWidget(
                textEditingController: controller.searchController,
                controller: controller,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: controller.searchResults.isNotEmpty
                    ? const SearchResultWidget()
                    : ListItemView(
                        future: controller.getWordData(),
                        controller: controller,
                        crossAxisCount: 0,
                        itemCount: 15,
                        isMobile: true,
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
