import 'package:dev_dictionary/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/drawer_widget.dart';
import '../../components/home_list_view_item.dart';
import '../../components/search_bar_widget.dart';
import '../../components/search_result_widget.dart';
import '../../controllers/word_data_controller.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor:
                controller.isDarkMode.value ? Colors.white : bgColor,
            drawer: const DrawerWidget(),
            appBar: AppBar(
              elevation: 0,
              backgroundColor:
                  controller.isDarkMode.value ? Colors.white : bgColor,
              leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Image.asset(
                  'assets/icons/menu.png',
                  color:
                      controller.isDarkMode.value ? Colors.black : Colors.white,
                  height: 25,
                ),
              ),
            ),
            body: GetBuilder<WordDataController>(
                init: WordDataController(),
                builder: (controller) {
                  return Column(
                    children: [
                      Center(
                        child: Text(
                          'Dev Dictionary',
                          style: GoogleFonts.oswald(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: controller.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Programmer\'s Dictionary',
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: controller.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SearchBarWidget(
                        textEditingController: controller.searchController,
                        controller: controller,
                      ),
                      const SizedBox(height: 26.0),
                      Expanded(
                        child: controller.searhResults.isNotEmpty
                            ? const SearchResultWidget()
                            : const HomeListViewItem(),
                      ),
                    ],
                  );
                }),
          );
        });
  }
}
