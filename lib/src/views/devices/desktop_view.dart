import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/footer_widget.dart';
import '../../components/top_header_widget.dart';
import '../../controllers/word_data_controller.dart';

class DesktopView extends StatelessWidget {
  DesktopView({Key? key}) : super(key: key);
  final WordDataController wordController = Get.put(WordDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<WordDataController>(
            init: WordDataController(),
            builder: (controller) {
              final postController = Get.put(WordDataController());
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 200),
                    child: Column(
                      children: [
                        TopHeaderDesktop(),
                        const SizedBox(height: 50),
                        const Center(
                          child: Text(
                            'ডেভ ডিকশনারি',
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Borno',
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'ডেভেলপারদের জন্য মাতৃভাষা বাংলায় সবচেয়ে \nবড় তথ্য ভান্ডার',
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
                                style: const TextStyle(),
                                onChanged: (String query) {
                                  if (query.isNotEmpty) {
                                    postController.searchData(query.trim());
                                    controller.update();
                                  } else {
                                    postController.searhResults.clear();
                                    controller.update();
                                  }
                                },
                                controller: postController.searchController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 16),
                                  hintText: 'শব্দের অর্থ খুঁজুন...',
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
                                  suffixIcon: postController
                                          .searchController.text.isEmpty
                                      ? null
                                      : IconButton(
                                          onPressed: () {
                                            postController.searchController
                                                .clear();
                                            postController.searhResults.clear();
                                            controller.update();
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
                        postController.searhResults.isNotEmpty
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
                                              postController.searhResults
                                                  .length, (index) {
                                            final topic = postController
                                                .searhResults[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                        BorderRadius.circular(
                                                            10),
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
                                    itemCount: postController
                                        .getPaginatedData()
                                        .length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 3.5,
                                    ),
                                    itemBuilder: (context, index) {
                                      final topic = postController
                                          .getPaginatedData()[index];

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
                                              context.go('/details/${topic.en}',
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
                        if (postController.searhResults.isEmpty)
                          postController.wordData.isEmpty
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (postController.currentPage > 1) {
                                          postController.currentPage--;
                                          postController.update();
                                          if (postController.currentPage == 1) {
                                            context.go('/');
                                          } else {
                                            context.go(
                                                '/?page=${postController.currentPage}');
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.arrow_back_ios),
                                    ),
                                    Text(
                                      'Page ${postController.currentPage}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Borno',
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (postController.currentPage <
                                            (postController.wordData.length /
                                                    postController.itemsPerPage)
                                                .ceil()) {
                                          postController.currentPage++;
                                          postController.update();
                                          if (postController.currentPage == 1) {
                                            context.go('/');
                                          } else {
                                            context.go(
                                                '/?page=${postController.currentPage}');
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
