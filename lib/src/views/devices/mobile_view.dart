import 'package:dev_dictionary/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/drawer_widget.dart';
import '../../components/home_list_view_item.dart';
import '../../components/search_bar_widget.dart';
import '../../components/search_result_widget.dart';
import '../../controllers/word_data_controller.dart';

class MobileView extends StatelessWidget {
  MobileView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: const DrawerWidget(),
            appBar: AppBar(
              elevation: 0,
              leading: Container(
                margin: const EdgeInsets.all(10),
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Image.asset(
                    'assets/icons/menu.png',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            body: GetBuilder<WordDataController>(
                init: WordDataController(),
                builder: (controller) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'ডেভ',
                                style: TextStyle(
                                  fontSize: 40,
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
                              fontSize: 40,
                              fontFamily: 'Borno',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          AppConstants.appSlug,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SearchBarWidget(
                        textEditingController: controller.searchController,
                        controller: controller,
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: controller.searhResults.isNotEmpty
                            ? const SearchResultWidget()
                            : HomeListViewItem(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }),
          );
        });
  }
}
