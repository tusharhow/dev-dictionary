import 'package:dev_dictionary/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/home_list_view_item.dart';
import '../../components/search_result_widget.dart';
import '../../controllers/word_data.dart';
import '../bookmark/bookmark_screen.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor,
      drawer: Drawer(
        child: Container(
          color: bgColor,
          child: ListView(children: [
            const SizedBox(height: 50),
            Center(
              child: Text(
                'Dev Dictionary',
                style: GoogleFonts.oswald(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 50),
            ListTile(
              onTap: () {
                Get.to(() => const BookMarkScreen());
              },
              leading: const Icon(
                Icons.bookmark,
                color: Colors.white,
                size: 30,
              ),
              title: const Text(
                'Bookmark',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: defaultPadding,
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              title: const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: defaultPadding,
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.info,
                color: Colors.white,
                size: 30,
              ),
              title: const Text(
                'About',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: defaultPadding,
                ),
              ),
            ),
          ]),
        ),
      ),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.lightbulb_outline,
                color: Colors.white,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )),
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
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Programmer\'s Dictionary',
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: bgColor2,
                        hintText: 'কিছু লিখুন...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: controller.searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear,
                                    color: Colors.white54),
                                onPressed: () {
                                  controller.searchData('');
                                  controller.searchController.clear();
                                },
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          controller.searchData(value);
                        } else {
                          controller.searchData('');
                        }
                      },
                      onEditingComplete: () {
                        if (controller.searchController.text.isNotEmpty) {
                          controller
                              .searchData(controller.searchController.text);
                        } else {
                          controller.searchData('');
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (controller.searchController.text.isNotEmpty) {
                          controller
                              .searchData(controller.searchController.text);
                        } else {
                          controller.searchData('');
                        }
                      },
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
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
  }
}
