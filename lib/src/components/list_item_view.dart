import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItemView extends StatelessWidget {
  const ListItemView({
    super.key,
    required this.future,
    required this.crossAxisCount,
    required this.itemCount,
    required this.isMobile,
    required this.controller,
  });
  final Future<List<Word>> future;
  final int crossAxisCount;
  final int itemCount;
  final bool isMobile;
  final WordDataController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Word>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (isMobile) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                controller: controller.scrollController,
                itemCount: controller.getPaginatedData().length +
                    (controller.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.getPaginatedData().length) {
                    if (controller.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }

                  final word = controller.getPaginatedData()[index];
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              word.en.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              word.bn,
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Borno',
                              ),
                            ),
                          ],
                        ),
                        hoverColor: Colors.deepPurple.shade200,
                        onTap: () {
                          context.go(
                            '/${AppRouteConstants.detailsRouteName}/${word.en}',
                            extra: word,
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return GridView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: itemCount,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) {
                  final topic = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                topic.en.toUpperCase(),
                                style: GoogleFonts.inter(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Flexible(
                              child: Text(
                                topic.bn,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Borno',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        hoverColor: Colors.deepPurple.shade200,
                        onTap: () {
                          context.go(
                              '/${AppRouteConstants.detailsRouteName}/${topic.en}',
                              extra: topic);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
