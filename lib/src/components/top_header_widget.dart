import 'package:dev_dictionary/src/controllers/theme_controller.dart';
import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TopHeaderDesktop extends StatelessWidget {
  const TopHeaderDesktop({super.key});

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
                return TextButton.icon(
                  onPressed: () {
                    wordPropertyController.urlLauncher(
                        'https://github.com/tusharhow/dev-dictionary');
                  },
                  icon: Consumer<ThemeController>(
                      builder: (context, themeController, c) {
                    return Icon(
                      Icons.star_border_rounded,
                      size: 30,
                      color: themeController.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    );
                  }),
                  label: Consumer<ThemeController>(
                      builder: (context, themeController, c) {
                    return Text(
                      'Github',
                      style: TextStyle(
                        color: themeController.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    );
                  }),
                );
              }),
              const SizedBox(width: 20),
              Consumer<ThemeController>(builder: (context, themeController, c) {
                return TextButton.icon(
                  style: TextButton.styleFrom(
                    iconColor: themeController.isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                  onPressed: () {
                    context.go('/bookmarks');
                  },
                  icon: Icon(
                    Icons.bookmarks_outlined,
                    size: 25,
                    color: themeController.isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                  label: Text(
                    'Bookmarks',
                    style: TextStyle(
                      color: themeController.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                );
              }),
              const SizedBox(width: 16),
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
