import 'package:dev_dictionary/src/models/word_model.dart';
import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/word_data_controller.dart';

class HomeListViewItem extends StatelessWidget {
  const HomeListViewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WordDataController>(builder: (context, controller, child) {
      return FutureBuilder<List<Word>>(
          future: controller.getShuffledWordData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 25,
                  itemBuilder: (context, index) {
                    var word = snapshot.data![index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          context.go(
                              '/${AppRouteConstants.detailsRouteName}/${word.en}',
                              extra: word);
                        },
                        child: Card(
                          elevation: 2,
                          child: SizedBox(
                            height: 75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  word.en.toUpperCase(),
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  word.bn,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          });
    });
  }
}
