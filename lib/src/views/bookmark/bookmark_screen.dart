import 'package:dev_dictionary/constants.dart';
import 'package:dev_dictionary/src/controllers/bookmark_controller.dart';
import 'package:dev_dictionary/src/router/app_route_constants.dart';
import 'package:dev_dictionary/src/views/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BookmarkController>(builder: (context, controller, child) {
        return Center(
          child: SizedBox(
            width: Responsive.isDesktop(context) || Responsive.isTablet(context)
                ? MediaQuery.of(context).size.width / 1.7
                : double.infinity,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 50,
                      width: 50,
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
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
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
                                    borderRadius: BorderRadius.circular(12),
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
            ),
          ),
        );
      }),
    );
  }
}
