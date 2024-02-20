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
            backgroundColor: bgColor,
            drawer: const DrawerWidget(),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.blueGrey[600],
              leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Image.asset(
                  'assets/icons/menu.png',
                  height: 25,
                  color: Colors.white,
                ),
              ),
            ),
            body: GetBuilder<WordDataController>(
                init: WordDataController(),
                builder: (controller) {
                  return Column(
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[600],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
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
                                    color: Colors.white,
                                    fontFamily: 'Borno',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                'Programmer\'s Dictionary',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            SearchBarWidget(
                              textEditingController:
                                  controller.searchController,
                              controller: controller,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: controller.searhResults.isNotEmpty
                            ? const SearchResultWidget()
                            : HomeListViewItem(),
                      ),
                    ],
                  );
                }),
          );
        });
  }
}
