import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/views/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopHeaderDesktop extends StatelessWidget {
  const TopHeaderDesktop({Key? key, required this.controller})
      : super(key: key);
  final WordDataController controller;
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
                  color: Colors.deepOrange,
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
              Text(
                'ডিকশনারি',
                style: TextStyle(
                  fontSize: 25,
                  color:
                      controller.isDarkMode.value ? Colors.white : Colors.black,
                  fontFamily: 'Borno',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  controller.urlLauncher(
                      'https://github.com/tusharhow/dev-dictionary');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.star_border_rounded,
                      color: controller.isDarkMode.value
                          ? Colors.white60
                          : Colors.black54,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Github',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: controller.isDarkMode.value
                            ? Colors.white60
                            : Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 20),
                    GetBuilder<WordDataController>(
                        builder: (controller) => IconButton(
                            icon: Icon(
                              controller.isDarkMode.value
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                              color: controller.isDarkMode.value
                                  ? Colors.white60
                                  : Colors.black54,
                            ),
                            onPressed: () => controller.toggleDarkMode())),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                          return const SettingsScreen();
                        }));
                      },
                      child: Image.asset(
                        'assets/icons/menu.png',
                        color: controller.isDarkMode.value
                            ? Colors.white60
                            : Colors.black54,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
