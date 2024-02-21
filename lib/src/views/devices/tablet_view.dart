import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/footer_widget.dart';
import '../../components/top_header_widget.dart';
import '../../controllers/word_data_controller.dart';
import '../../models/word_model.dart';
import '../detail/desktop_details_page.dart';

class TabletView extends StatelessWidget {
  const TabletView({Key? key}) : super(key: key);

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
                  TopHeaderDesktop(),
                  const SizedBox(height: 30),
                  const Center(
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
                  const Text(
                    'ডেভেলপারদের জন্য মাতৃভাষা বাংলায় সবচেয়ে \nবড় তথ্য ভান্ডার',
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'Borno',
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 5,
                      child: SizedBox(
                        height: 55,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black45),
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
                            hintStyle: const TextStyle(color: Colors.black38),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            suffixIcon: postController
                                    .searchController.text.isEmpty
                                ? null
                                : IconButton(
                                    onPressed: () {
                                      postController.searchController.clear();
                                      postController.searhResults.clear();
                                      controller.update();
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.black38,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
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
                                        postController.searhResults.length,
                                        (index) {
                                      final topic =
                                          postController.searhResults[index];
                                      return ListTile(
                                        title: Text(topic.bn,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontFamily: 'Borno',
                                            )),
                                        leading: const Icon(
                                          Icons.search,
                                          color: Colors.blue,
                                          size: 40,
                                        ),
                                        subtitle: Text(topic.en,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Borno',
                                              color: Colors.black45,
                                            )),
                                        onTap: () {
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
                                primary: false,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3.8,
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
                                            topic.bn,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontFamily: 'Borno',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        hoverColor: Colors.blue.shade100,
                                        tileColor: Colors.white,
                                        onTap: () {
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
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                  const SizedBox(height: 100),
                  const FooterWidget(),
                ],
              );
            }),
      ),
    );
  }
}
