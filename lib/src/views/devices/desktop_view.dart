import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/footer_widget.dart';
import '../../components/top_header_widget.dart';
import '../../controllers/word_data_controller.dart';
import '../../models/word_model.dart';
import '../detail/desktop_details_page.dart';

class DesktopView extends StatelessWidget {
  DesktopView({Key? key}) : super(key: key);

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
                        Center(
                          child: Text(
                            'ডেভ ডিকশনারি',
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Borno',
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'ডেভেলপারদের জন্য মাতৃভাষা বাংলায় সবচেয়ে \nবড় তথ্য ভান্ডার',
                          style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'Borno',
                            color: Colors.black54,
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
                                style: TextStyle(color: Colors.black45),
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
                                  hintText: 'কীসের উপর সার্চ করতে চান?',
                                  hintStyle: TextStyle(
                                    color: Colors.black45,
                                  ),
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
                                          icon: Icon(Icons.clear,
                                              color: Colors.black45),
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
                                            return ListTile(
                                              title: Text(
                                                topic.en.toUpperCase(),
                                                style: const TextStyle(
                                                  fontSize: 22,
                                                  fontFamily: 'Borno',
                                                ),
                                              ),
                                              leading: const Icon(
                                                Icons.search,
                                                color: Colors.blue,
                                                size: 40,
                                              ),
                                              subtitle: Text(topic.bn,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Borno',
                                                    color: Colors.black45,
                                                  )),
                                              onTap: () {
                                                postController.update();
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        BigScreenDetailsPage(
                                                      word: topic,
                                                    ),
                                                  ),
                                                );
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : FutureBuilder<List<Word>>(
                                future: postController.getShuffledWordData(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 3.5,
                                      ),
                                      itemBuilder: (context, index) {
                                        final topic = snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            elevation: 1,
                                            child: ListTile(
                                              title: Center(
                                                child: Text(
                                                  topic.en.toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'Borno',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                              hoverColor: Colors.blue.shade100,
                                              tileColor: Colors.white,
                                              onTap: () {
                                                postController.update();
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        BigScreenDetailsPage(
                                                      word: topic,
                                                    ),
                                                  ),
                                                );
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                }),
                        const SizedBox(height: 20),
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
