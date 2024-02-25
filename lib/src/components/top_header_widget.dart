import 'package:dev_dictionary/src/controllers/theme_controller.dart';
import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TopHeaderDesktop extends StatelessWidget {
  const TopHeaderDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 100, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Center(
                  child: Text(
                    'ডেভ',
                    style: TextStyle(
                      fontSize: 25,
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
                  fontSize: 25,
                  fontFamily: 'Borno',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer<WordPropertyController>(
                  builder: (context, wordPropertyController, c) {
                return GestureDetector(
                  onTap: () {
                    wordPropertyController.urlLauncher(
                        'https://github.com/tusharhow/dev-dictionary');
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.star_border_rounded,
                        size: 30,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Github',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  context.go('/bookmarks');
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.bookmarks_outlined,
                      size: 25,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Bookmarks',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Consumer<ThemeController>(builder: (context, themeController, c) {
                return IconButton(
                  onPressed: () {
                    themeController.toggleDarkMode();
                  },
                  icon: Icon(
                    themeController.isDarkMode
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    size: 25,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
