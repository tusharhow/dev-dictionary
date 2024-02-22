import 'package:dev_dictionary/src/controllers/theme_controller.dart';
import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:dev_dictionary/src/controllers/word_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import '../../components/popup_widget.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final WordPropertyController wordPropertyController =
      Get.put(WordPropertyController());
  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
              ),
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            body: GetBuilder<WordDataController>(
                init: WordDataController(),
                builder: (controller) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                buildPopupDialog(context),
                          );
                        },
                        leading: const Icon(
                          Icons.format_size,
                          size: 25,
                        ),
                        title: const Text(
                          'Change Font Size',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select Theme'),
                                content: SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: const Text('Light Theme'),
                                        leading: const Icon(
                                          Icons.light_mode,
                                          size: 25,
                                        ),
                                        onTap: () {
                                          themeController.toggleDarkMode();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('Dark Theme'),
                                        leading: const Icon(
                                          Icons.dark_mode,
                                          size: 25,
                                        ),
                                        onTap: () {
                                          themeController.toggleDarkMode();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        leading: const Icon(
                          Icons.brightness_6,
                          size: 25,
                        ),
                        title: const Text(
                          'Change Theme',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          FlutterShare.share(
                            title: 'Share App',
                            text: 'Share App',
                            linkUrl: 'https://play.google.com/store/apps',
                            chooserTitle: 'Share App',
                          );
                        },
                        leading: const Icon(
                          Icons.share,
                          size: 25,
                        ),
                        title: const Text(
                          'Share App',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(
                          Icons.star,
                          size: 25,
                        ),
                        title: const Text(
                          'Rate App',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          );
        });
  }
}
