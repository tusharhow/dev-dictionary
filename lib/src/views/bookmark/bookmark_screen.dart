import 'package:dev_dictionary/src/controllers/bookmark_controller.dart';
import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: Consumer<BookmarkController>(builder: (context, controller, child) {
        return Column(
          children: [
            Expanded(
                child: controller.bookmarks.isEmpty
                    ? const Center(
                        child: Text('No bookmarked words'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.bookmarks.length,
                        itemBuilder: (BuildContext context, index) {
                          final bookmark = controller.bookmarks[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff5db962),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                  onTap: () {
                                    context.go(
                                        '/${AppRouteConstants.detailsRouteName}/${bookmark.en}',
                                        extra: bookmark);
                                  },
                                  title: Text(
                                    bookmark.en.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  subtitle: Text(
                                    bookmark.bn,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      controller.removeBookmark(
                                          controller.bookmarks[index]);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )),
                            ),
                          );
                        },
                      ))
          ],
        );
      }),
    );
  }
}
