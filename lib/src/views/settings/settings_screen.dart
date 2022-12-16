import 'package:dev_dictionary/src/controllers/word_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../components/popup_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor:
                controller.isDarkMode.value ? Colors.white : bgColor,
            appBar: AppBar(
              backgroundColor:
                  controller.isDarkMode.value ? Colors.white : bgColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color:
                      controller.isDarkMode.value ? Colors.black : Colors.white,
                  size: 25,
                ),
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color:
                      controller.isDarkMode.value ? Colors.black : Colors.white,
                  fontSize: controller.fontSize.value,
                ),
              ),
            ),
            body: GetBuilder<WordDataController>(
                init: WordDataController(),
                builder: (controller) {
                  return Column(
                    children: [
                      const SizedBox(height: defaultPadding),
                      ListTile(
                        onTap: () {
                          //  controller.changeTheme();
                          // change theme dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                changeThemePopupDialog(context),
                          );
                        },
                        leading: Icon(
                          Icons.lightbulb_outline,
                          color: controller.isDarkMode.value
                              ? Colors.black
                              : Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Change Theme',
                          style: TextStyle(
                            color: controller.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
                            fontSize: controller.fontSize.value,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                buildPopupDialog(context),
                          );
                        },
                        leading: Icon(
                          Icons.format_size,
                          color: controller.isDarkMode.value
                              ? Colors.black
                              : Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Change Font Size',
                          style: TextStyle(
                            color: controller.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
                            fontSize: controller.fontSize.value,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.share,
                          color: controller.isDarkMode.value
                              ? Colors.black
                              : Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Share App',
                          style: TextStyle(
                            color: controller.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
                            fontSize: controller.fontSize.value,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.star,
                          color: controller.isDarkMode.value
                              ? Colors.black
                              : Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Rate App',
                          style: TextStyle(
                            color: controller.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
                            fontSize: controller.fontSize.value,
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.logout,
                          color: controller.isDarkMode.value
                              ? Colors.black
                              : Colors.white,
                          size: 30,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            color: controller.isDarkMode.value
                                ? Colors.black
                                : Colors.white,
                            fontSize: controller.fontSize.value,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          );
        });
  }

  Widget changeThemePopupDialog(BuildContext context) {
    return GetBuilder<WordDataController>(
        init: WordDataController(),
        builder: (controller) {
          return AlertDialog(
            backgroundColor:
                controller.isDarkMode.value ? Colors.white : bgColor,
            title: Text(
              'Change Theme',
              style: TextStyle(
                color:
                    controller.isDarkMode.value ? Colors.black : Colors.white,
                fontSize: controller.fontSize.value,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    controller.isDarkMode.value == true
                        ? controller.changeTheme()
                        : null;
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.lightbulb_outline,
                    color: controller.isDarkMode.value
                        ? Colors.black
                        : Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(
                      color: controller.isDarkMode.value
                          ? Colors.black
                          : Colors.white,
                      fontSize: controller.fontSize.value,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    controller.isDarkMode.value == false
                        ? controller.changeTheme()
                        : null;
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.lightbulb_outline,
                    color: controller.isDarkMode.value
                        ? Colors.black
                        : Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    'Light Mode',
                    style: TextStyle(
                      color: controller.isDarkMode.value
                          ? Colors.black
                          : Colors.white,
                      fontSize: controller.fontSize.value,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
